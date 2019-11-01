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
      file_names.push({ name: File.basename(image.path), type: 'image' })
    end

    documents&.each do |document|
      file_names.push({ name: File.basename(document.path), type: 'document' })
    end

    voices&.each do |voice|
      file_names.push({ name:File.basename(voice&.path), type: 'voice' })
    end

    videos&.each do |video|
      file_names.push({name: File.basename(video&.path), type: 'video' })
    end


    file_names
  end

end
