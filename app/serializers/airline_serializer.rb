class AirlineSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone
  belongs_to :country
end
