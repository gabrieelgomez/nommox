module Api::V1::Cases
  class UpdateController < CasesController
    before_action :set_case

    def update
      handle_edit
      render json: @case, status: 200
    end

    def update_status
      if @case.update(status: params.dig(:status))
        render json: @case, status: 200
      else
        render json: @case.errors
      end
    end

    def add_test
      @test = @case.tests

      add_images(@test, params.dig(:test, :images))
      add_videos(@test, params.dig(:test, :videos))
      add_voices(@test, params.dig(:test, :voices))
      add_documents(@test, params.dig(:test, :documents))

      render json: { uploaded: true }, status: 200
    end

    def companion_documents
      @case = Case.find_by_id(params.dig(:id))
      return if @case.nil?

      companion = @case.companions.find_by_id(params.dig(:companion))

      unless companion.nil?
        companion.update(
          identification_document: params.dig(:user, :front).nil? ? companion.identification_document : params.dig(:user, :front),
          back: params.dig(:user, :back).nil? ? companion.back : params.dig(:user, :back),
          passport: params.dig(:user, :passport).nil? ? companion.passport : params.dig(:user, :passport)
        )
      end

      render json: {
        id: companion.id,
        names: companion.names,
        surnames: companion.surnames,
        identification: companion.identification_document,
        back: companion.back,
        passport: companion.passport
      }, status: 200
    end

    private

    def handle_edit
      edit_case
      edit_booking
      edit_inconvenience
      edit_tests
    end

    def add_images(test, images)
      return if images.blank?
      test.update(images: test.images.push(images).flatten)
    end

    def add_videos(test, videos)
      return if videos.blank?
      test.update(videos: test.videos.push(videos).flatten)
    end

    def add_voices(test, voices)
      return if voices.blank?
      test.update(voices: test.voices.push(voices).flatten)
    end

    def add_documents(test, documents)
      return if documents.blank?
      test.update(documents: test.documents.push(documents).flatten)
    end

    def edit_case
      return if params[:case].nil?

      @case.update(case_params)
    end

    def edit_booking
      return if params[:booking].nil?

      @booking = @case.booking
      @booking.update(booking_params)
    end

    def edit_inconvenience
      return if params[:inconvenience].nil?

      @inconvenience = @case.inconvenience
      @inconvenience.update(inconvenience_params)
    end

    def edit_tests
      return if params[:test].nil?

      @tests = @case.tests
      @tests.update(test_params)
    end

  end
end
