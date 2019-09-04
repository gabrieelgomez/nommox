module Api::V1::Boardingpass
  class SearchController < BoardingpassController
    before_action :set_airlines
    before_action :set_airports

    def filter
      from    = params.dig(:from)&.upcase
      to      = params.dig(:to)&.upcase
      airline = params.dig(:airline)&.upcase

      @result = Array.new
      @airline = @airlines.dig(airline)

      @airports.each do |airport|
        @from = "#{airport['name']} - #{airport['code']}"
        break if airport['code'].upcase.eql?(from)
      end

      @airports.each do |airport|
        @to = "#{airport['name']} - #{airport['code']}"
        break if airport['code'].upcase.eql?(to)
      end

      @result.push(build_hash(@from, @to, @airline))

      render json: @result, status: 200
    end

  end
end
