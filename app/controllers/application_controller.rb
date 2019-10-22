class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  helper_method :current_user

  include Pundit
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def respond_to_formats(action, objects)
    respond_to do |format|
      format.html { render action }
      format.json { render json: objects }
    end
  end

  def current_user
    return if is_json_request?
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def is_json_request?
    request.format.symbol.eql?(:json)
  end

  def authenticate_user
    redirect_to login_path unless current_user.present?
  end

  private

  def user_not_authorized
    return unless request.format.symbol.eql?(:html)
    flash[:alert] = "No tiene permiso para realizar ésta acción."
    redirect_to(root_path)
  end

end
