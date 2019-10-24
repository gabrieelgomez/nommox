class UserSerializer < ActiveModel::Serializer
  attributes  :email, :name, :phone, :firm,
              :passport, :video, :asesor_cases

  attribute  :country_name, key: :country
  attribute  :city_name,    key: :department
  attribute  :province_name, key: :city

  attribute :identification_document, key: :identification
end
