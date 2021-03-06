module Api::V1
  class Airlines::AirlinesController < ApiController

    private

    def airline_params
      params.require(:airline).permit(:name, :phone, :country_id, :code)
    end

    def set_airline
      @airline = Airline.find_by_id(params.dig(:airline_id)) || Object.new
    end

    def set_airlines
      @airlines = YAML.load_file("#{Rails.root}/config/airlines.yml")
    end
  end
end
