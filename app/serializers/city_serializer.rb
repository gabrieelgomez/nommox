class CitySerializer < ActiveModel::Serializer
  has_many :provinces
  attributes :id, :name

end
