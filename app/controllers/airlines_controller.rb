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
      respond_to do |format|
        format.html { redirect_to :airlines }
        format.json { render json: @airline }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @airline.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @airline.update(airline_params)
        format.html { redirect_to @airline, notice: 'Airline was successfully updated.' }
        format.json { render json: @airline, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @airline.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to_formats(:show, @airline)
  end

  def destroy
    @airline.destroy
    respond_to do |format|
      format.html { redirect_to airlines_url, notice: 'Airline was successfully destroyed.' }
      format.json { head :no_content }
    end
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
