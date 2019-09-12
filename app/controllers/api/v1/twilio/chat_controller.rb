require 'twilio-ruby'

module Api::V1::Twilio
  class ChatController < TwilioController
    before_action :load_credentials, only: [:call, :connect, :access_token]
    # before_action :authenticate_twilio_request, only: [:connect]

    def access_token
      # Required for Chat
      service_sid = @service_sid
      identity    = 'user@example.com'

      # Create Chat grant for our token
      grant = Twilio::JWT::AccessToken::ChatGrant.new
      grant.service_sid = service_sid

      # Create an Access Token
      token = Twilio::JWT::AccessToken.new(
        @twilio_sid,
        @app_sid,
        @app_secret,
        [grant],
        identity: identity
      )

      render json: token.to_jwt
    end

  end
end
