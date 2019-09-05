class SessionsController < ApplicationController
  layout 'front'

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to main_path
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
