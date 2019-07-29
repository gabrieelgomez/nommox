class ApplicationController < ActionController::Base
  helper_method :current_user

  def respond_to_formats(action, objects)
    respond_to do |format|
      format.html { render action }
      format.json { render json: objects }
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

end