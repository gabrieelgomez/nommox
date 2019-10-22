class CountriesController < InternalController
  before_action :set_country, only: %i[edit update show destroy]

  def index
    @countries = Country.page(params.dig(:page) || 1).includes(:cities)
    respond_to_formats(:index, @countries)
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)

    if @country.save
      respond_to do |format|
        format.html { redirect_to :countries }
        format.json { render json: @country }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to @country, notice: 'Country was successfully updated.' }
        format.json { render json: @country, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to_formats(:show, @country)
  end

  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_url, notice: 'Country was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_country
    @country = Country.find_by_id(params.dig(:id))
  end

  def country_params
    params.require(:country).permit(:name)
  end
end
