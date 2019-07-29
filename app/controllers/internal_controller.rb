class InternalController < ApplicationController
  before_action :authenticate
   protect_from_forgery with: :null_session

  def respond_to_formats(action, objects)
    respond_to do |format|
      format.html { render action }
      format.json { render json: objects }
    end
  end

  def authenticate
    if request.format.symbol.eql?(:html)
      session[:controller] = nil
      session[:action] = nil
      unless current_user
        session[:user_id] = nil
        session[:controller] = controller_name
        session[:action] = action_name
        redirect_to login_path, notice: "You need to login first"
      end
    end
  end

end
