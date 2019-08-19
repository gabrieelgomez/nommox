module Api::V1::Cases
  class CreateController < CasesController
    include Concerns::Cases::HandleCasesData

    def create
      @user = find_or_create_user

      if @user.valid?
        create_case(@user.id)
      else
        render json: @user.errors, status: 500
      end
    end
  end
end
