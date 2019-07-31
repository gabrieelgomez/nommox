class LocationsController < InternalController
  def countries
    @countries = Country.includes(:cities)
    respond_to_formats(:countries, @countries)
  end

  def cities
    @cities = City.includes(:provinces)
    respond_to_formats(:cities, @cities)
  end

  def get_cities
    @cities = Country.find_by_id(params.dig(:country_id))&.cities

    respond_to do |format|
      format.js
      format.json { render json: @cities }
    end
  end
end
