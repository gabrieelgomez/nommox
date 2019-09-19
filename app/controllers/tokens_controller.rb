
class TokensController < ApplicationController
  before_action :load_credentials

  def create
    # Define User Identity
     identity = current_user.email

     # Create Grant for Access Token
     grant = Twilio::JWT::AccessToken::ChatGrant.new
     grant.service_sid         = @service_sid
     grant.push_credential_sid = @push_credential_sid

     # Create an Access Token
     token = Twilio::JWT::AccessToken.new(
       @twilio_sid,
       @app_sid,
       @app_secret,
       [grant],
       identity: identity
     )

     # Generate the token and send to client
     render json: { identity: identity, token: token.to_jwt }
  end

  private

  def load_credentials
    @twilio_sid          = ENV["TWILIO_SID"]
    @twilio_token        = ENV["TWILIO_TOKEN"]
    @twilio_number       = ENV["TWILIO_NUMBER"]
    @app_sid             = ENV["APP_SID"]
    @app_secret          = ENV["APP_SECRET"]
    @twiml_sid           = ENV["TWIML_SID"]
    @service_sid         = ENV["SERVICE_SID"]
    @push_credential_sid = ENV["PUSH_CREDENTIAL_SID"]
  end

end
