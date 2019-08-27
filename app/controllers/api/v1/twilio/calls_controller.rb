module Api::V1::Twilio
  class CallsController < TwilioController
    before_action :load_credentials, only: [:call, :connect]
    before_action :authenticate_twilio_request, only: [:connect]
    
    # Handle a POST from our web form and connect a call via REST API
    def call
      @client = Twilio::REST::Client.new @twilio_sid, @twilio_token
      # Connect an outbound call to the number submitted
      @call = @client.calls.create(
        to:   '+584121281876',
        from: @twilio_number,
        url: "#{@api_host}/api/v1/twilio/connect/+18002842622/call" # Fetch instructions from this URL when the call connects
      )

      # Let's respond to the ajax call with some positive reinforcement
      @msg = { message: 'Phone call incoming!', status: 'ok' }

      render json: @msg
    end

    # This URL contains instructions for the call that is connected with a lead
    # that is using the web form.
    def connect
      response = Twilio::TwiML::VoiceResponse.new do |r|
        r.dial number: '+18002842622'
      end

      render xml: response.to_s
    end

    # Authenticate that all requests to our public-facing TwiML pages are
    # coming from Twilio. Adapted from the example at
    # http://twilio-ruby.readthedocs.org/en/latest/usage/validation.html
    # Read more on Twilio Security at https://www.twilio.com/docs/security
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
      @twilio_sid    = 'AC50de35afe1e9d2766abd19690247c604'
      @twilio_token  = 'c1107bf787f15766a2a55a778409c902'
      @twilio_number = '+17864851185'
      @api_host      = 'http://18.224.54.238'
    end

  end
end
