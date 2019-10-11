class UserSerializer < ActiveModel::Serializer
  attributes  :id, :email, :name, :phone, :firm,
              :passport, :video

  attribute :identification_document, key: :identification

  belongs_to :country
  belongs_to :city
  belongs_to :province
end
