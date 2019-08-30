class LettersController < ApplicationController
  before_action :set_letter, only: %i[edit update show destroy]
  before_action :set_countries, only: %i[new create edit update]

  def index
    @letters = Airline.all.includes(:country)
    respond_to_formats(:index, @letters)
  end

  def new
    @letter = Airline.new
  end

  def create
    @letter = Airline.new(letter_params)

    if @letter.save
      respond_to do |format|
        format.html { redirect_to :letters }
        format.json { render json: @letter }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @letter.update(letter_params)
        format.html { redirect_to @letter, notice: 'Airline was successfully updated.' }
        format.json { render json: @letter, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to_formats(:show, @letter)
  end

  def destroy
    @letter.destroy
    respond_to do |format|
      format.html { redirect_to letters_url, notice: 'Airline was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_letter
    @letter = Airline.find_by_id(params.dig(:id))
  end

  def letter_params
    params.require(:letter).permit(:name, :phone, :country_id)
  end

  def set_countries
    @countries = Country.all.select(:id, :name)
  end
end
