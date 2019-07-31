class ProvincesController < ApplicationController
  before_action :set_province, only: %i[edit update show destroy]
  before_action :set_cities, only: %i[new create edit update]

  def index
    @provinces = Province.all
  end

  def new
    @province = Province.new
  end

  def create
    @province = Province.new(province_params)

    if @province.save
      redirect_to :provinces
    else
      redirect_back(fallback_location: :provinces_path)
    end
  end

  def edit; end

  def update
    if @province.update(province_params)
      redirect_to :provinces
    else
      redirect_back(fallback_location: :provinces_path)
    end
  end

  def show; end

  def destroy
    @province.destroy
    redirect_back(fallback_location: :provinces_path)
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
