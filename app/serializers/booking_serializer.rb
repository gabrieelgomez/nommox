class BookingSerializer < ActiveModel::Serializer
  attributes :id
  attribute :parsed_companions, key: :companions

  has_many :companions
end
