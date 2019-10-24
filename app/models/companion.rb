class Companion < ApplicationRecord
  belongs_to :case

  mount_uploader :identification_document, AttachmentUploader
  mount_uploader :passport,                AttachmentUploader
end
