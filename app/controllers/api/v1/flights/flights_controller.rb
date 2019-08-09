module Api::V1
  class Flights::FlightsController < ApiController

    private

    def set_flight
      @flight = Flight.find_by_id(params.dig(:flight_id)) || Object.new
    end

    def flight_params
      params.require(:flight).permit(
        :departure_airport_code, :arrival_airport_code, :departure_airport_name,
        :arrival_airport_name, :date, :hour, :airline_id, :flight_number
      )
    end
  end
end
