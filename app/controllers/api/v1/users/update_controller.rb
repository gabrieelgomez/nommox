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
      if user.nil?
        User.create(
          email: params.dig(:email),
          name: params.dig(:name),
          identification_document_front: params.dig(:user, :front),
          identification_document_back:  params.dig(:user, :back),
          passport: params.dig(:user, :passport),
          firm: params.dig(:user, :signature),
          video: params.dig(:user, :video),
          role_id: '4',
          password: '+nommox+'
        )
      else
        user.update(
          name: params.dig(:name).nil? ? user.name : params.dig(:name),
          identification_document_front: params.dig(:user, :front).nil? ? user.identification_document_front : params.dig(:user, :front),
          identification_document_back:  params.dig(:user, :back).nil? ? user.identification_document_back : params.dig(:user, :back),
          passport: params.dig(:user, :passport).nil? ? user.passport : params.dig(:user, :passport),
          firm: params.dig(:user, :signature).nil? ? user.firm : params.dig(:user, :signature),
          video: params.dig(:user, :video).nil? ? user.video : params.dig(:user, :video)
        )
      end

      render json: { status: 'User was succesfully updated' }
    end

  end
end
