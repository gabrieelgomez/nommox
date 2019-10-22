class CarouselConfigurationsController < InternalController
  before_action :authenticate
  before_action :set_carousel_configuration, only: %i[edit update show destroy]

  def index
    @carousel_configurations = CarouselConfiguration.page(params.dig(:page) || 1)
    respond_to_formats(:index, @carousel_configurations)
  end

  def new
    @carousel_configuration = CarouselConfiguration.new
  end

  def create
    @carousel_configuration = CarouselConfiguration.new(carousel_configuration_params)

    if @carousel_configuration.save
      respond_to do |format|
        format.html { redirect_to :carousel_configurations }
        format.json { render json: @carousel_configuration }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @carousel_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @carousel_configuration.update(carousel_configuration_params)
        format.html { redirect_to @carousel_configuration, notice: 'City was successfully updated.' }
        format.json { render json: @carousel_configuration, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @carousel_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to_formats(:show, @carousel_configuration)
  end

  def destroy
    @carousel_configuration.destroy
    respond_to do |format|
      format.html { redirect_to carousel_configurations_url, notice: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def carousel_configuration_params
    params.require(:carousel_configuration).permit(:text)
  end

  def set_carousel_configuration
    @carousel_configuration = CarouselConfiguration.find_by_id(
                                params.dig(:id)
                              )
  end
end
