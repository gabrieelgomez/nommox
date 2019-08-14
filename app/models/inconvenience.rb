class Inconvenience < ApplicationRecord
  belongs_to :case

  #uploader
  mount_uploader :image, AttachmentUploader
end
