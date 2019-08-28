module Api::V1::Users
  class CreateController < UsersController

    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: 200
      else
        render json: @user.errors, status: 500
      end
    end
  end
end
