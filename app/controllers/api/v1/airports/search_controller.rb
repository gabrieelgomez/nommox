module Api::V1
  class Airports::SearchController < ApiController
    before_action :set_airports

    def filter_airports
      query = params.dig(:query)&.downcase
      @results = Array.new

      @airports.each do |a|
        next unless a['country']&.downcase&.include?(query) ||
                    a['city']&.downcase&.include?(query)    ||
                    a['code']&.downcase&.include?(query)    ||
                    a['tz']&.downcase&.include?(query)      ||
                    a['name']&.downcase&.include?(query)

        @results.push(build_hash(a))
      end

      render json: @results, status: 200
    end

    private

    def set_airports
      @airports = YAML.load_file("#{Rails.root}/config/airports.yml")
    end

    def build_hash(data)
      temp_hash = Hash.new
      temp_hash[:code]    = data['code']
      temp_hash[:lat]     = data['lat']
      temp_hash[:lon]     = data['lon']
      temp_hash[:name]    = data['name']
      temp_hash[:country] = data['country']
      temp_hash[:city]    = data['city']
      temp_hash[:state]   = data['state']
      temp_hash[:icao]    = data['icao']
      temp_hash[:display] = "#{data['name']} - #{data['code']}"

      temp_hash
    end
  end
end
