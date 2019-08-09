module Api::V1
  class Carousels::CarouselsController < ApiController

    private

    def carousel_params
      params.require(:carousel).permit(:text)
    end

    def set_carousel
      @carousel = CarouselConfiguration.find_by_id(params.dig(:carousel_id)) || Object.new
    end
  end
end
