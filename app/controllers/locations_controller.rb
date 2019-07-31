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
    respond_to_formats(:get_cities, @cities)
  end

  def get_provinces
    @provinces = City.find_by_id(params.dig(:city_id))&.provinces
    respond_to_formats(:get_provinces, @provinces)
  end
end
