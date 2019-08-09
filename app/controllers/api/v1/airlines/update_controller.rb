module Api::V1::Airlines
  class UpdateController < AirlinesController
    before_action :set_airline

    def update
      if @airline.update(airline_params)
        render json: @airline, status: 200
      else
        render json: @airline.errors, status: 500
      end
    end
  end
end
