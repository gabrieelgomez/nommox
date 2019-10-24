class FlightSerializer < ActiveModel::Serializer
  attributes :id, :hour, :airline
  attribute  :departure_airport_name, key: :from
  attribute  :arrival_airport_name,   key: :to
  attribute  :flight_number,          key: :number
  attribute  :date_parsed,            key: :date

  has_many :companions
end
