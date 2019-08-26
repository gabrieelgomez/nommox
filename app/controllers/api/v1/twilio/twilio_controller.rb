module Api::V1
  class Twilio::TwilioController < ApiController
    skip_before_action :verify_authenticity_token
  end
end
