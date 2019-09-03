module Api::V1
  class Boardingpass::BoardingpassController < ApiController
    def set_airlines
      @airlines = YAML.load_file("#{Rails.root}/config/airlines.yml")
    end

    def set_airports
      @airports = YAML.load_file("#{Rails.root}/config/airports.yml")
    end

    def build_hash(departure, arrival, airline)
      temp_hash = Hash.new
      temp_hash[:departure_airport] = departure
      temp_hash[:arrival_airport]   = arrival
      temp_hash[:airline]           = airline

      temp_hash
    end
  end
end
