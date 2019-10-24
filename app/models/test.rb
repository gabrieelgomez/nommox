class Test < ApplicationRecord
  belongs_to :case

  #uploaders
  mount_uploaders :images,    AttachmentUploader
  mount_uploaders :videos,    AttachmentUploader
  mount_uploaders :voices,    AttachmentUploader
  mount_uploaders :documents, AttachmentUploader

  def names
    file_names = Array.new

    [images, documents, voices, videos].each do |file_type|
      file_type.each do |file|
        file_names.push(File.basename(file.path))
      end
    end

    file_names
  end

end
