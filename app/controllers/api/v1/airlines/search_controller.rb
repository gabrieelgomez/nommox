module Api::V1::Airlines
  class SearchController < AirlinesController

    before_action :set_airlines, only: %i[filter_airlines]

    def find_airline
      query = params.dig(:query)
      @airline = Airline.where("name LIKE :query", query: "%#{query}%")
      render json: @airline, status: 200
    end

    def filter_airlines
      query = decode(params.dig(:query)&.upcase)
      @results = Array.new

      @airlines.each do |a|
        if decode(a[0]).include?(query) || decode(a[1]).upcase.include?(query)
          @results.push(build_hash(a))
        end
      end

      render json: @results
    end

    private

    def build_hash(data)
      temp_hash = Hash.new

      temp_hash[:code] = data[0]
      temp_hash[:name] = data[1]

      temp_hash
    end

    def decode(str)
      I18n.transliterate(str)
    end
  end
end
