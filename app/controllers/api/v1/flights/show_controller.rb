module Api::V1::Flights
  class ShowController < FlightsController

    before_action :set_flight, only: %i[show]

    def index
      @flights = Flight.all
      render json: @flights, status: 200
    end

    def show
      render json: @flight, status: 200
    end
  end
end
