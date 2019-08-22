class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def is_super_admin?
    @user.has_role?(:super_admin) || @user.has_role?(:admin)
  end
end