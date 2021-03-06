class UserSerializer < ActiveModel::Serializer
  attributes  :email, :name, :phone, :firm,
              :passport, :video, :asesor_cases

  attribute  :identification_document_front, key: :identification
  attribute  :identification_document_back,  key: :back
  attribute  :country_name, key: :country
  attribute  :city_name,    key: :department
  attribute  :province_name, key: :city
end
