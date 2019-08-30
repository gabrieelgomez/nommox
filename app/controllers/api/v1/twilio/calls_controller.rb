require 'twilio-ruby'
require 'pry'

module Api::V1::Twilio
  class CallsController < TwilioController
    before_action :load_credentials, only: [:call, :connect, :access_token]
    # before_action :authenticate_twilio_request, only: [:connect]

    # Handle a POST from our web form and connect a call via REST API
    def call
    #   call_request      = CallRequest.new
    #   call_request.from = params.dig(:from)
    #   call_request.to   = params.dig(:to)
    #
    #
    # # Validate contact
    # if call_request.valid?
      @client = Twilio::REST::Client.new @twilio_sid, @twilio_token
      # Connect an outbound call to the number submitted
      @call = @client.calls.create(
        to:   '+584121281876',
        from: '+17864851185',
        url: 'http://demo.twilio.com/docs/voice.xml',
        # url: "http://991f84ae.ngrok.io/api/v1/twilio/connect/#{call_request.encoded_to_phone}" # Fetch instructions from this URL when the call connects
      )

      @msg = { message: 'Phone call incoming!', status: 'ok' }


    # else
    #   @msg = { message: call_request.errors.full_messages, status: 'ok' }
    # end
    #   puts call_request.encoded_to_phone
      render json: @msg
    end

    # This URL contains instructions for the call that is connected with a lead
    # that is using the web form.
    def connect
      response = Twilio::TwiML::VoiceResponse.new
      response.dial(number: params.dig(:to))
      response.say(message: 'Goodbye')

      puts response
    end

    def access_token
      account_sid = @twilio_sid
      api_key     = @app_sid
      api_secret  = @app_secret

      # Required for Voice
      outgoing_application_sid = @twiml_sid
      identity = 'user'

      # Create Voice grant for our token
      grant = Twilio::JWT::AccessToken::VoiceGrant.new
      grant.outgoing_application_sid = outgoing_application_sid

      # Optional: add to allow incoming calls
      grant.incoming_allow = true

      # Create an Access Token
      token = Twilio::JWT::AccessToken.new(
        account_sid,
        api_key,
        api_secret,
        [grant],
        identity: identity
      )

      # Generate the token
      render json: token.to_jwt
    end

    private

    def authenticate_twilio_request
      if twilio_req?
        return true
      else
        response = Twilio::TwiML::VoiceResponse.new do|r|
          r.hangup
        end

        render xml: response.to_s, status: :unauthorized
        false
      end
    end

    def twilio_req?
      # Helper from twilio-ruby to validate requests.
      validator = Twilio::Security::RequestValidator.new(@twilio_token)

      # the POST variables attached to the request (eg "From", "To")
      # Twilio requests only accept lowercase letters. So scrub here:
      post_vars = params.reject { |k, _| k.downcase == k }
      twilio_signature = request.headers['HTTP_X_TWILIO_SIGNATURE']

      validator.validate(request.url, post_vars, twilio_signature)
    end

    def load_credentials
      # Define our Twilio credentials as instance variables for later use
      @twilio_sid    = ENV["TWILIO_SID"]
      @twilio_token  = ENV["TWILIO_TOKEN"]
      @twilio_number = ENV["TWILIO_NUMBER"]
      @api_host      = 'http://991f84ae.ngrok.io'
      @app_sid       = 'SK5afcdc97d82d5baa9b59897f8156ded5'
      @app_secret    = 'ThKkEQUljKl6foS57NR20tc8kaM4QTCE'
      @twiml_sid     = 'APf86663ec0a3429c8f2baafe0f31520a9'
    end

  end
end
