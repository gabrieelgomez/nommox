class Ticket < ApplicationRecord
  mount_uploaders :tickets, AttachmentUploader
end
