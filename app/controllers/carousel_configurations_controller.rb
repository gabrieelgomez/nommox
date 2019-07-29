class CarouselConfigurationsController < InternalController
  before_action :authenticate
  before_action :set_carousel_configuration, only: %i[edit update show destroy]

  def index
    @carousel_configurations = CarouselConfiguration.all
    respond_to_formats(:index, @carousel_configurations)
  end

  def new
    @carousel_configuration = CarouselConfiguration.new
  end

  def create
    @carousel_configuration = CarouselConfiguration.new(carousel_configuration_params)

    if @carousel_configuration.save
      redirect_to :carousel_configurations
    else
      redirect_back(fallback_location: :carousel_configurations_path)
    end
  end

  def edit; end

  def update
    if @carousel_configuration.update!(carousel_configuration_params)
      redirect_to :carousel_configurations
    else
      redirect_back(fallback_location: :carousel_configurations_path)
    end
  end

  def show; end

  def destroy
    @carousel_configuration.destroy
    redirect_to :carousel_configurations
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
