module Api::V1::Carousels
  class UpdateController < CarouselsController
    before_action :set_carousel

    def update
      if @carousel.update(carousel_params)
        render json: @carousel, status: 200
      else
        render json: @carousel.errors, status: 500
      end
    end
  end
end
