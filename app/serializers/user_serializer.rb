class UserSerializer < ActiveModel::Serializer
  attributes  :id, :email, :name, :phone, :identification_document, :firm,
              :passport, :video

  belongs_to :country
  belongs_to :city
  belongs_to :province
end
