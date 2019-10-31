module Api::V1::Users
  class UpdateController < UsersController
    before_action :set_user, only: %i[update]

    def update
      if @user.update(user_params)
        render json: @user, status: 200
      else
        render json: @user.errors, status: 500
      end
    end

    def add_documents
      user = User.find_by_email(params.dig(:email))
      byebug
      return if user.nil?
      #pending for implementation
    end

  end
end
