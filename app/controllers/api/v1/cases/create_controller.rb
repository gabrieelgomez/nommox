module Api::V1::Cases
  class CreateController < CasesController

    def create
      @case = CaseCause.new(case_params)
      if @case.save
        render json: @case, status: 200
      else
        render json: @case.errors, status: 500
      end
    end

  end
end
