class SessionsController < ApplicationController
  layout 'front'

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:controller] && session[:action]
        flash[:alert] = "Logged in!"
        begin
          redirect_to controller: session[:controller], action: session[:action]
        rescue ActionController::UrlGenerationError
          redirect_to main_path
        end
      else
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
