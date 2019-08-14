class Companion < ApplicationRecord
  belongs_to :booking

  mount_uploader :identification_document, AttachmentUploader
  mount_uploader :passport,                AttachmentUploader
end
