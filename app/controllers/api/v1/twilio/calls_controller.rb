require 'twilio-ruby'

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
      to:   params.dig(:to),
      from: '+18179184011',
      url: "https://nommox.com/api/v1/twilio/connect/#{params.dig(:to)}" # Fetch instructions from this URL when the call connects
    )

    # @msg = { message: 'Phone call incoming!', status: 'ok' }


    # else
    #   @msg = { message: call_request.errors.full_messages, status: 'ok' }
    # end
    #   puts call_request.encoded_to_phone
      respond_to do |format|
        format.json { render json: @msg }
        format.xml
      end
    end

    # This URL contains instructions for the call that is connected with a lead
    # that is using the web form.
    def connect
      # response = Twilio::TwiML::VoiceResponse.new do |r|
      #   r.dial number: params.dig(:to)
      # end
      response = Twilio::TwiML::VoiceResponse.new
      response.say(message: 'Thanks for use nommox!')

      render xml: response.to_xml
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
      @twilio_sid    = ENV["TWILIO_SID"]
      @twilio_token  = ENV["TWILIO_TOKEN"]
      @twilio_number = ENV["TWILIO_NUMBER"]
      @app_sid       = ENV["APP_SID"]
      @app_secret    = ENV["APP_SECRET"]
      @twiml_sid     = ENV["TWIML_SID"]
      @host          = 'https://nommox.com/api/v1/'
    end

  end
end
