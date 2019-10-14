require 'twilio-ruby'

module Api::V1::Twilio
  class ChatController < TwilioController
    before_action :load_credentials, only: [:call, :connect, :access_token]
    # before_action :authenticate_twilio_request, only: [:connect]

    def access_token
      # Required for Chat
      identity = params&.dig(:identity) || 'default'

      # Create Chat grant for our token
      grant = Twilio::JWT::AccessToken::ChatGrant.new
      grant.service_sid         = @service_sid
      grant.push_credential_sid = @push_credential_apn_sid

      puts @service_sid
      puts @push_credential_apn_sid

      puts grant.inspect
      # Create an Access Token
      token = Twilio::JWT::AccessToken.new(
        @twilio_sid,
        @app_sid,
        @app_secret,
        [grant],
        identity: identity
      )

      render json: { token: token.to_jwt }
    end

    def message_received
      @channel  = UnreadMessage.find_by_channel(params.dig('ChannelSid'))
      @activity = Activity.find_by_channel(params.dig('ChannelSid'))
      @message  = params.dig(:Body)
      @identity = params.dig(:ClientIdentity)

      unless @identity.eql?(current_user.email)
        if @channel.present?
          @channel.update(messages_count: @channel.messages_count.to_i + 1)
        else
          @channel = UnreadMessage.create(channel: params.dig('ChannelSid'), messages_count: 1)
        end
      end

      send_notification(@activity, @message, @identity)
    end

    def get_unread_messages
      @channel = UnreadMessage.find_by_channel(params.dig('channel_sid'))

      render json: @channel
    end

    def remove_unread_messages
      @channel = UnreadMessage.find_by_channel(params.dig('channel_sid'))
      @channel.update(messages_count: 0) if @channel.present?
    end

    private

    def send_notification(activity, message, identity)
      return if activity.token.nil? || activity.identity.eql?(identity)

      pusher = Grocer.pusher(
        certificate: "#{Rails.root}/pushcert.pem",      # required,
        gateway: 'gateway.push.apple.com',
      )

      notification = Grocer::Notification.new(
        device_token: activity.token,
        alert:        "Chat: #{message}",
        badge:        1,
        sound:        "siren.aiff",         # optional
      )

      pusher.push(notification) # return value is the number of bytes sent successfully
    end

  end
end
