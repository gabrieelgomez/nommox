class CountriesController < InternalController
  before_action :set_country, only: %i[edit update show destroy]

  def index
    @countries = Country.includes(:cities)
    respond_to_formats(:index, @countries)
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)

    if @country.save
      redirect_to :countries
    else
      redirect_back(fallback_location: :countries_path)
    end
  end

  def edit; end

  def update
    if @country.update(country_params)
      redirect_to :countries
    else
      redirect_back(fallback_location: :countries_path)
    end
  end

  def show
    respond_to_formats(:show, @country)
  end

  def destroy
    @country.destroy
    redirect_back(fallback_location: :countries_path)
  end

  private

  def set_country
    @country = Country.find_by_id(params.dig(:id))
  end

  def country_params
    params.require(:country).permit(:name)
  end
end
