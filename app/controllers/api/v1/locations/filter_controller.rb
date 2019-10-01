module Api::V1::Locations
  class FilterController < LocationsController
    def countries
      @countries = Country.all
      render json: @countries, status: 200
    end

    def get_cities
      @cities = Country.find_by_id(params.dig(:country_id))&.cities || Object.new
      render json: @cities, status: 200
    end

    def get_provinces
      @provinces = City.find_by_id(params.dig(:city_id))&.provinces  || Object.new
      render json: @provinces, status: 200
    end
  end
end
