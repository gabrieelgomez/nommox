class Test < ApplicationRecord
  belongs_to :case

  #uploaders
  mount_uploaders :images,    AttachmentUploader
  mount_uploaders :videos,    AttachmentUploader
  mount_uploaders :voices,    AttachmentUploader
  mount_uploaders :documents, AttachmentUploader
end
