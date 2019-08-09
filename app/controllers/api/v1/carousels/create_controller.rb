module Api::V1::Carousels
  class CreateController < CarouselsController

    def create
      @carousel = CarouselConfiguration.new(carousel_params)
      if @carousel.save
        render json: @carousel, status: 200
      else
        render json: @carousel.errors, status: 500
      end
    end

  end
end
