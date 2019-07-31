class AirlinesController < ApplicationController
  before_action :set_airline, only: %i[edit update show destroy]
  before_action :set_countries, only: %i[new create edit update]

  def index
    @airlines = Airline.all.includes(:country)
    respond_to_formats(:index, @airlines)
  end

  def new
    @airline = Airline.new
  end

  def create
    @airline = Airline.new(airline_params)

    if @airline.save
      redirect_to :airlines
    else
      redirect_back(fallback_location: :airlines_path)
    end
  end

  def edit; end

  def update
    if @airline.update(airline_params)
      redirect_to :airlines
    else
      redirect_back(fallback_location: :airlines_path)
    end
  end

  def show; end

  def destroy
    @airline.destroy
    redirect_back(fallback_location: :airlines_path)
  end

  def search
    query = params.dig(:query)
    @airline = Airline.where("name LIKE :query", query: "%#{query}%")
    respond_to_formats(:index, @airline)
  end

  private

  def set_airline
    @airline = Airline.find_by_id(params.dig(:id))
  end

  def airline_params
    params.require(:airline).permit(:name, :phone, :country_id)
  end

  def set_countries
    @countries = Country.all.select(:id, :name)
  end
end
