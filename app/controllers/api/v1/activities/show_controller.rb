module Api::V1::Activities
  class ShowController < ActivityController

    before_action :set_activity, only: %i[show]

    def show
      render json: @activity, status: 200
    end
  end
end
