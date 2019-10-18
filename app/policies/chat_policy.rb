class ChatPolicy < Struct.new(:user, :chat)

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.has_role?(:asesor) || @user.has_role?(:super_admin)  || @user.has_role?(:admin) 
  end
end
