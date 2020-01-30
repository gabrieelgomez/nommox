class VerificationCode < ApplicationRecord
  validates_presence_of :phone

  def self.build_verification_code(phone, token_fcm)
    verification = VerificationCode.find_by(phone: phone)

    if verification.nil?
      verification = VerificationCode.create(
        phone: phone,
        code: generate_code,
        token_fcm: token_fcm,
        sended_code: false
      )
    elsif verification.sended_code
      return nil
    end

    verification
  end

  private

  def self.generate_code
    exist = true

    while exist
      random = random_code
      exist  = VerificationCode.where(code: random).exists?
    end

    random
  end

  def self.random_code
    Kernel.srand.to_s.split('').first(6).join().to_i
  end
end
