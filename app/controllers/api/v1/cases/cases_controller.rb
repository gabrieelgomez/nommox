module Api::V1
  class Cases::CasesController < ApiController

    private

    def case_params
      params.require(:case).permit(
        :status, :video_self, :hours_late, :notifications_enabled, :user_id,
        :done, { case_cause_ids: [] }
      )
    end

    def user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :phone, :country_id,
        :province_id, :city_id, :identification_document, :passport, :firm,
        :video, :role_id
      )
    end

    def test_params
      params.require(:test).permit(
        { videos: [] }, { images: [] }, { voices: [] }, { documents: [] }
      )
    end

    def inconvenience_params
      params.require(:inconvenience).permit(
        :lost_connection, :lost_event, :description, :case_id, :image
      )
    end

    def booking_params
      params.require(:booking).permit(:code)
    end

    def companion_params
      params.require(:companion).permit(
        :names, :surnames, :identification_document, :passport
      )
    end

    def set_case
      @case = Case.find_by_id(params.dig(:case_id)) || Object.new
    end
  end
end
