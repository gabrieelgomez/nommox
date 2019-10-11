module Api::V1
  class Cases::CasesController < ApiController

    private

    def set_case
      @case = Case.find_by_id(params.dig(:case_id)) || Object.new
    end
  end
end
