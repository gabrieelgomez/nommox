module Api::V1::Users
  class UpdateController < UsersController
    before_action :set_user

    def update
      if @user.update(user_params)
        render json: @user, status: 200
      else
        render json: @user.errors, status: 500
      end
    end
  end
end
