class FlightSerializer < ActiveModel::Serializer
  attributes  :id, :departure_airport_code, :arrival_airport_code,
              :departure_airport_name,  :arrival_airport_name, :date, :hour,
              :airline_id, :flight_number

  belongs_to :airline
end
