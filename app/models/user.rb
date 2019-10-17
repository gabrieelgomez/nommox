class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates_presence_of :name, :role_id
  after_commit :reload_identification_document, on: [:create, :update]

  #uploader
  mount_uploader :identification_document,       AttachmentUploader
  mount_uploader :identification_document_back,  AttachmentUploader
  mount_uploader :identification_document_front, AttachmentUploader
  mount_uploader :passport,                      AttachmentUploader
  mount_uploader :firm,                          AttachmentUploader
  mount_uploader :video,                         AttachmentUploader

  #locations
  belongs_to :country,  optional: true
  belongs_to :city,     optional: true
  belongs_to :province, optional: true
  belongs_to :role
  has_many   :cases, dependent: :destroy

  def has_role?(role_name)
    role&.name&.to_sym&.eql?(role_name) || false
  end

  private

  def reload_identification_document
    return if self.identification_document_front.url.nil? && self.identification_document_back.url.nil?
    kit = IMGKit.new(build_image)
    img = kit.to_file("#{Rails.root}/public/#{self.id}.png")
    self.identification_document = img
  end

  def build_image
    "<img src='http://18.224.54.238#{self.identification_document_front.url}' style='width: auto; height: auto;'></img>
    <br>
    <img src='http://18.224.54.238#{self.identification_document_back.url}' style='width: auto; height: auto;'></img>"
  end

end
