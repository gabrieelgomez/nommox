class Carousel::CarouselConfigurationController < ApplicationController
  def index
    @texts = CarouselConfiguration.all
    respond_to_formats(:index, @texts)
  end
end
