class VerificationCode < ApplicationRecord
  validates_presence_of :phone

  def self.build_verification_code(phone)
    verification = VerificationCode.where(phone: phone).first

    if verification.valid?
      verification.update(code: generate_code)
    else
      verification = VerificationCode.create(
        phone: phone,
        code: generate_code
      )
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
