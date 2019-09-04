class AirlineSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :code
  belongs_to :country
end
