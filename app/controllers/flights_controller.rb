class FlightsController < ApplicationController
  before_action :set_flight, only: %i[edit update show destroy]
  before_action :set_airlines, only: %i[new create edit update]

  def index
    @flights = Flight.all
    respond_to_formats(:index, @flights)
  end

  def new
    @flight = Flight.new
  end

  def create
    @flight = Flight.new(flight_params)

    if @flight.save
      respond_to do |format|
        format.html { redirect_to :flights }
        format.json { render json: @flight }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to @flight, notice: 'Flight was successfully updated.' }
        format.json { render json: @flight, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to_formats(:show, @flight)
  end

  def destroy
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to flights_url, notice: 'Flight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_flight
    @flight = Flight.find_by_id(params.dig(:id))
  end

  def flight_params
    params.require(:flight).permit(
      :departure_airport_code, :arrival_airport_code, :departure_airport_name,
      :arrival_airport_name, :date, :hour, :airline_id, :flight_number
    )
  end

  def set_airlines
    @airlines = Airline.all.select(:id, :name)
  end
end
