module Api::V1::Users
  class ShowController < UsersController

    before_action :set_user, only: %i[show]

    def index
      @users = User.all.includes(:country, :city, :province, :role)
      render json: @users, status: 200
    end

    def show
      render json: @user, status: 200
    end
  end
end
