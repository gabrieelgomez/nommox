module Api::V1::Airlines
  class SearchController < AirlinesController

    def find_airline
      query = params.dig(:query)
      @airline = Airline.where("name LIKE :query", query: "%#{query}%")
      render json: @airline, status: 200
    end
    
  end
end
