class UsersController < InternalController
  before_action :authenticate , except: [:new, :create, :send_confirmation_code]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_variables, only: [:new, :edit, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.page(params.dig(:page) || 1).includes(:country, :city, :province)
    respond_to_formats(:index, @users)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to_formats(:show, @user)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    # respond_to do |format|
    if @user.save
      respond_to do |format|
        format.html { redirect_to users_path }
        format.json { render json: @user }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render json: @user, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_current_user
    render json: current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_variables
      @countries = Country.all.select(:id, :name)
      @cities    = City.all.select(:id, :name)
      @provinces = Province.all.select(:id, :name)
      @roles     = Role.all.select(:id, :name)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :phone, :country_id,
        :province_id, :city_id, :identification_document, :passport, :firm,
        :video, :role_id
      )
    end
end
