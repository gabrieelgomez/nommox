module Api::V1::Flights
  class CreateController < FlightsController

    def create
      @flight = Flight.new(flight_params)
      if @flight.save
        render json: @flight, status: 200
      else
        render json: @flight.errors, status: 500
      end
    end

  end
end
