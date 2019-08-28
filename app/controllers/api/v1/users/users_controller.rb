module Api::V1
  class Users::UsersController < ApiController

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :phone, :country_id,
        :province_id, :city_id, :identification_document_front,
        :identification_document_back, :passport, :firm,
        :video, :role_id
      )
    end
  end
end
