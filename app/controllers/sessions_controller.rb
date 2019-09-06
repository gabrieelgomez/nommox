class SessionsController < ApplicationController
  layout 'front'

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      respond_to do |format|
        format.html { redirect_to 'https://nommox.com/main' }
      end
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:controller] = nil
    session[:action] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
