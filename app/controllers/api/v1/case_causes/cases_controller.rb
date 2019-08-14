module Api::V1
  class CaseCauses::CasesController < ApiController

    private

    def case_params
      params.require(:case).permit(:name)
    end

    def set_case
      @case = CaseCause.find_by_id(params.dig(:case_id)) || Object.new
    end
  end
end
