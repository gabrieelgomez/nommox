class ProvincesController < ApplicationController
  before_action :set_province, only: %i[edit update show destroy]
  before_action :set_cities, only: %i[new create edit update]

  def index
    @provinces = Province.page(params.dig(:page) || 1).includes(:city)
    respond_to_formats(:index, @provinces)
  end

  def new
    @province = Province.new
  end

  def create
    @province = Province.new(province_params)

    if @province.save
      respond_to do |format|
        format.html { redirect_to :provinces }
        format.json { render json: @province }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @province.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @province.update(province_params)
        format.html { redirect_to @province, notice: 'Province was successfully updated.' }
        format.json { render json: @province, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @province.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to_formats(:show, @province)
  end

  def destroy
    @province.destroy
    respond_to do |format|
      format.html { redirect_to provinces_url, notice: 'Province was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_province
    @province = Province.find_by_id(params.dig(:id))
  end

  def province_params
    params.require(:province).permit(:name, :city_id)
  end

  def set_cities
    @cities = City.all.select(:id, :name)
  end
end
