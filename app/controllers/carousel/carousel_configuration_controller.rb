class Carousel::CarouselConfigurationController < ApplicationController
  before_action :set_carousel_configuration, only: %i[edit update destroy]

  def index
    @carousel_texts = CarouselConfiguration.all
    respond_to_formats(:index, @carousel_texts)
  end

  def new
    @carousel_configuration = CarouselConfiguration.new
  end

  def create
    @text = CarouselConfiguration.new(carousel_configuration_params)

    if @text.save
      redirect_to :carousel_texts
    else
      redirect_back(fallback_location: :carousel_texts_path)
    end
  end

  def edit; end

  def update
    if @carousel_configuration.update!(carousel_configuration_params)
      redirect_to :carousel_texts
    else
      redirect_back(fallback_location: :carousel_texts_path)
    end
  end

  def show; end

  def destroy
    @carousel_configuration.destroy
    redirect_back(fallback_location: :carousel_texts_path)
  end

  private

  def carousel_configuration_params
    params.require(:carousel_configuration).permit(:text)
  end

  def set_carousel_configuration
    @carousel_configuration = CarouselConfiguration.find(
                                params.dig(:carousel_configuration_id)
                              )
  end
end
