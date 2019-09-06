class SessionsController < ApplicationController
  layout 'front'

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      puts "************************* #{user.inspect}"
      puts "************************* #{params}"
      session[:user_id] = user.id
      respond_to do |format|
        format.html { redirect_to main_url }
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
