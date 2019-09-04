module Api::V1
  class Boardingpass::BoardingpassController < ApiController
    def set_airlines
      @airlines = YAML.load_file("#{Rails.root}/config/airlines.yml")
    end

    def set_airports
      @airports = YAML.load_file("#{Rails.root}/config/airports.yml")
    end

    def build_hash(from, to, airline)
      temp_hash = Hash.new
      temp_hash[:from]    = from
      temp_hash[:to]      = to
      temp_hash[:airline] = airline

      temp_hash
    end
  end
end
