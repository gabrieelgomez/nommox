module Api::V1
  class Letters::LettersController < ApiController

    def get_letter
      @letter = Letter.find_by(country_id: params.dig(:country_id)) || Object.new
      render json: @letter
    end

  end
end
