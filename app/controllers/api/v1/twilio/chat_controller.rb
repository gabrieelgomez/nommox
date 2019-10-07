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
    end

  end
end
