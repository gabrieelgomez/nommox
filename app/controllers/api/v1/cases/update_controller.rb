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

    def add_test
      @test = @case.tests

      add_images(@test, params.dig(:test, :images))
      add_videos(@test, params.dig(:test, :videos))
      add_voices(@test, params.dig(:test, :voices))
      add_documents(@test, params.dig(:test, :documents))

      render json: @case, status: 200
    end

    private

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

  end
end
