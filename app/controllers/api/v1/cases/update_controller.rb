module Api::V1::Cases
  class UpdateController < CasesController
    before_action :set_case

    def update
      if @case.update(case_params)
        render json: @case, status: 200
      else
        render json: @case.errors, status: 500
      end
    end
  end
end
