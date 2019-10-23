require 'twilio-ruby'

module Api::V1::Twilio
  class VerificationController < TwilioController
    before_action :load_credentials, only: [:send_confirmation_code]

    def send_confirmation_code
      to = params.dig(:to)

      verification = VerificationCode.build_verification_code(to)

      if verification.valid?
        send_message(to, verification.code)
      else
        render json: { error: true }
      end
    end

    def validate_code
      phone = params.dig(:phone)
      code  = params.dig(:code)

      verification = VerificationCode.find_by_phone(phone)
      valid = verification.valid? ? verification.code.eql?(code) : false

      render json: { valid: valid }
    end

    private

    def send_message(to, code)
      client = Twilio::REST::Client.new(@twilio_sid, @twilio_token)

      client.messages.create(
        from: 'whatsapp:+14155238886',
        body: "Tú código de verificación de Nommox es: *#{code}*",
        to: "whatsapp:#{to}"
      )

      render json: { send: true }
    end

  end
end
