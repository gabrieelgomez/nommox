class UsersController < InternalController
  before_action :authenticate , except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_variables, only: [:new, :edit, :create]
  # layout 'front', only: [:new]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
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
      respond_to_formats(:index, @user)
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
        format.json { render :show, status: :ok, location: @user }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_variables
      @countries = Country.all.select(:id, :name)
      @cities   = City.all.select(:id, :name)
      @provinces = Province.all.select(:id, :name)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :phone, :country_id,
        :province_id, :city_id, :identification_document, :passport, :firm, :video
      )
    end
end
