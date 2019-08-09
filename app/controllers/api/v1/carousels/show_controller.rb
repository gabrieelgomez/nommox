module Api::V1::Carousels
  class ShowController < CarouselsController

    before_action :set_carousel, only: %i[show]

    def index
      @carousels = CarouselConfiguration.all
      render json: @carousels, status: 200
    end

    def show
      render json: @carousel, status: 200
    end
  end
end
