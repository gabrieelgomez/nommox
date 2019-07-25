class Carousel::CarouselConfigurationController < ApplicationController
  def index
    @texts = CarouselConfiguration.all
    respond_to_formats(:index, @texts)
  end

  def new
    @carousel_configuration = CarouselConfiguration.new
  end

  def create
    @carousel_configuration = CarouselConfiguration.new(carousel_configuration_params)
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

  def carousel_configuration_params
    params.require(:carousel_configuration).permit(:text)
  end

  def set_carousel_configuration
    @carousel_configuration = CarouselConfiguration.find(params.dig(:id))
  end

end
