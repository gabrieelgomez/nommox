module Api::V1::Airlines
  class SearchController < AirlinesController

    before_action :set_airlines, only: %i[filter_airlines]

    def find_airline
      query = params.dig(:query)
      @airline = Airline.where("name LIKE :query", query: "%#{query}%")
      render json: @airline, status: 200
    end

    def filter_airlines
      query = params.dig(:query)&.upcase

      @result = Array.new
      @airline = @airlines.dig(airline)
      render json: @result[0], status: 200
    end
    
    private

    def build_hash(from, to, airline)
      temp_hash = Hash.new
      temp_hash[:from]    = from
      temp_hash[:to]      = to
      temp_hash[:airline] = airline

      temp_hash
    end


  end
end
