class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates_presence_of :name, :role_id

  #uploader
  mount_uploader :identification_document, AttachmentUploader
  mount_uploader :passport,                AttachmentUploader
  mount_uploader :firm,                    AttachmentUploader
  mount_uploader :video,                   AttachmentUploader

  #locations
  belongs_to :country,  optional: true
  belongs_to :cit,      optional: true
  belongs_to :province, optional: true
  belongs_to :role
  has_many   :cases, dependent: :destroy

  def has_role?(role_name)
    role&.name&.to_sym&.eql?(role_name) || false
  end
end
