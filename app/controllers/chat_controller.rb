class ChatController < ApplicationController
  before_action :authenticate_user
  layout 'front'

  def index
  end
end
