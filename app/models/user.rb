class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates_presence_of :name

  #uploader
  mount_uploader :identification_document, AttachmentUploader
  mount_uploader :passport,                AttachmentUploader
  mount_uploader :firm,                    AttachmentUploader
  mount_uploader :video,                   AttachmentUploader

  #locations
  belongs_to :country
  belongs_to :city
  belongs_to :province
end
