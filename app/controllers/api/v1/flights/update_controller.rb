module Api::V1::Flights
  class UpdateController < FlightsController
    before_action :set_flight

    def update
      if @flight.update(flight_params)
        render json: @flight, status: 200
      else
        render json: @flight.errors, status: 500
      end
    end
  end
end
