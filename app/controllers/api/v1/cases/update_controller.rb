module Api::V1::Cases
  class UpdateController < CasesController
    include Concerns::Cases::Editable
    before_action :set_case

    def update
      handle_edit
      render json: @case, status: 200
    end

    def add_test
      @test = @case.tests

      add_images(@test, params.dig(:test, :images))
      add_videos(@test, params.dig(:test, :videos))
      add_voices(@test, params.dig(:test, :voices))
      add_documents(@test, params.dig(:test, :documents))

      render json: @case, status: 200
    end

    private

    def handle_edit
      edit_case
      edit_booking
      edit_inconvenience
      edit_tests
      edit_tickets
    end
  end
end
