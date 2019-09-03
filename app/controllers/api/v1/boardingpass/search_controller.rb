module Api::V1::Boardingpass
  class SearchController < BoardingpassController
    before_action :set_airlines
    before_action :set_airports

    def filter
      to      = params.dig(:departure_airport_code)&.upcase
      from    = params.dig(:arrival_airport_code)&.upcase
      airline = params.dig(:airline_code)&.upcase

      @result = Array.new
      @airline = @airlines.dig(airline)

      @airports.each do |airport|
        @departure = "#{airport['name']} - #{airport['code']}"
        break if airport['code'].upcase.eql?(to)
      end

      @airports.each do |airport|
        @arrival = "#{airport['name']} - #{airport['code']}"
        break if airport['code'].upcase.eql?(from)
      end

      @result.push(build_hash(@departure, @arrival, @airline))

      render json: @result, status: 200
    end

  end
end
