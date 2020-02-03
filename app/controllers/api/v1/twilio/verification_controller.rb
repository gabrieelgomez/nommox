require 'twilio-ruby'

module Api::V1::Twilio
  class VerificationController < TwilioController
    before_action :load_credentials, only: [:send_confirmation_code]

    def send_confirmation_code
      to        = params.dig(:to)
      token_fcm = params.dig(:token_fcm)

      verification = VerificationCode.build_verification_code(to, token_fcm)

      if verification.nil?
        render json: { valid: false, message: 'Su código de verificación ya ha sido tomado.'}
      else
        send_message(token_fcm, verification.code)
      end
    end

    def validate_code
      phone = params.dig(:phone)
      code  = params.dig(:code)

      verification = VerificationCode.find_by_phone(phone)

      if verification.nil?
        valid   = false
        message = 'Su número no existe.'

      elsif verification && !verification&.code&.eql?(code)
        valid   = false
        message = 'Código erróneo.'

      elsif verification&.sended_code && verification&.code&.eql?(code)
        verification.update(sended_code: true)
        valid   = true
        message = 'Código válido.'

      elsif verification && verification&.sended_code
        valid   = false
        message = 'Su código de verificación ya ha sido tomado.'

      else
        valid   = false
        message = 'Error en una transaccion.'

      end

      render json: { valid: valid, message: message }
    end

    private

    def send_message(token_fcm, code)
      require 'firebase/fcm'

      message = "Tú código de verificación de Nommox es: #{code}"

      response = Fcm.send_message([token_fcm], Fcm.data_payload(message, '', {}))

      render json: { send: true, message: message, valid: true }
    end

  end
end
