module Api::V1::Airlines
  class ShowController < AirlinesController

    before_action :set_airline, only: %i[show]

    def index
      @airlines = Airline.all
      render json: @airlines, status: 200
    end

    def show
      render json: @airline, status: 200
    end
  end
end
