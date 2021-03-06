class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates_presence_of :name, :role_id

  scope :asesors, -> { where(role_id: 3) }

  #uploader
  mount_uploader :identification_document,       AttachmentUploader
  mount_uploader :identification_document_back,  AttachmentUploader
  mount_uploader :identification_document_front, AttachmentUploader
  mount_uploader :passport,                      AttachmentUploader
  mount_uploader :firm,                          AttachmentUploader
  mount_uploader :video,                         AttachmentUploader

  #locations
  belongs_to :country,  optional: true
  belongs_to :city,     optional: true
  belongs_to :province, optional: true
  belongs_to :role
  has_many   :cases, dependent: :destroy

  def has_role?(role_name)
    role&.name&.to_sym&.eql?(role_name) || false
  end

  def notify(case_obj)
    return unless SmtpSetting.first
    init_action_mailer_configuration
    NotificationMailer.notify(self, case_obj).deliver_now
  end

  def asesor_cases
    return [] if self.has_role?(:admin) || self.has_role?(:super_admin)

    channels = Case.where(asesor_id: self.id).map(&:user).map(&:email).uniq.compact

    if channels.empty? || channels.blank? || channels.nil?
      return 'not have channels availables'
    else
      return channels
    end
  end

  def country_name
    country&.name
  end

  def city_name
    city&.name
  end

  def province_name
    province&.name
  end

  private

  def init_action_mailer_configuration
    ActionMailer::Base.smtp_settings = {
      address: 'smtp.gmail.com',
      authentication: :plain,
      domain: 'gmail.com',
      port: 587,
      password: SmtpSetting.first&.password,
      user_name: 'noreply@nommox.com'
    }
  end

end
