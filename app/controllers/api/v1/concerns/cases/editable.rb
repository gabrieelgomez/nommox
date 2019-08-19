module Api::V1::Concerns
  module Cases::Editable
    extend ActiveSupport::Concern

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

    def edit_tickets
      return if params[:tickets].nil?

      @tickets = @case.tickets
      @tickets.update(tickets_params)
    end
  end
end
