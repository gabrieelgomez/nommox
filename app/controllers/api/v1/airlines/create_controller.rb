module Api::V1::Airlines
  class CreateController < AirlinesController

    def create
      @airline = Airline.new(airline_params)
      if @airline.save
        render json: @airline, status: 200
      else
        render json: @airline.errors, status: 500
      end
    end

  end
end
