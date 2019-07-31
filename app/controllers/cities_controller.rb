class CitiesController < ApplicationController
  before_action :set_city, only: %i[edit update show destroy]
  before_action :set_countries, only: %i[new create edit update]

  def index
    @cities = City.includes(:provinces)
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)

    if @city.save
      redirect_to :cities
    else
      redirect_back(fallback_location: :cities_path)
    end
  end

  def edit; end

  def update
    if @city.update(city_params)
      redirect_to :cities
    else
      redirect_back(fallback_location: :cities_path)
    end
  end

  def show; end

  def destroy
    @city.destroy
    redirect_back(fallback_location: :cities_path)
  end

  private

  def set_city
    @city = City.find_by_id(params.dig(:id))
  end

  def city_params
    params.require(:city).permit(:name, :country_id)
  end

  def set_countries
    @countries = Country.all.select(:id, :name)
  end
end
