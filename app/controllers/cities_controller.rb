class CitiesController < ApplicationController
  before_action :set_city, only: %i[edit update show destroy]
  before_action :set_countries, only: %i[new create edit update]

  def index

    @cities = City.page(params.dig(:page) || 1).includes(:provinces)
    respond_to_formats(:index, @cities)
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)

    if @city.save
      respond_to do |format|
        format.html { redirect_to :cities }
        format.json { render json: @city }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { render json: @city, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to_formats(:show, @city)
  end

  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url, notice: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
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
