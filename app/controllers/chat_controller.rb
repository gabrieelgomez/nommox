class ChatController < ApplicationController
  before_action :authenticate_user
  helper_method :current_user
  layout 'front'

  def index
    authorize :chat, :index?
  end
end
