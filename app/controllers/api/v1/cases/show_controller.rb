module Api::V1::Cases
  class ShowController < CasesController

    before_action :set_case, only: %i[show]

    def index
      @cases = CaseCause.all
      render json: @cases, status: 200
    end

    def show
      render json: @case, status: 200
    end
  end
end
