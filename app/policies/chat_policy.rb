class ChatPolicy < Struct.new(:user, :chat)

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.has_role?(:asesor)
  end
end
