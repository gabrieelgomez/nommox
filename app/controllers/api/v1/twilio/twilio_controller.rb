module Api::V1
  class Twilio::TwilioController < ApiController
    skip_before_action :verify_authenticity_token

    def load_credentials
      @twilio_sid              = ENV["TWILIO_SID"]
      @twilio_token            = ENV["TWILIO_TOKEN"]
      @twilio_number           = ENV["TWILIO_NUMBER"]
      @app_sid                 = ENV["APP_SID"]
      @app_secret              = ENV["APP_SECRET"]
      @twiml_sid               = ENV["TWIML_SID"]
      @service_sid             = ENV["SERVICE_SID"]
      @push_credential_apn_sid = ENV["PUSH_CREDENTIAL_APN_SID"]
    end

  end
end
