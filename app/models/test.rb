class Test < ApplicationRecord
  belongs_to :case

  #uploaders
  mount_uploaders :images,    AttachmentUploader
  mount_uploaders :videos,    AttachmentUploader
  mount_uploaders :voices,    AttachmentUploader
  mount_uploaders :documents, AttachmentUploader

  def names
    file_names = Array.new

    images&.each do |image|
      file_names.push(File.basename(image.path))
    end

    documents&.each do |document|
      file_names.push(File.basename(document.path))
    end

    voices&.each do |voice|
      file_names.push(File.basename(voice&.path))
    end

    videos&.each do |video|
      file_names.push(File.basename(video&.path))
    end


    file_names
  end

end
