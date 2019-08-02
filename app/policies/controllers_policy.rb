class ControllersPolicy < ApplicationPolicy
  def index?
    is_super_admin?
  end

  def new?
    is_super_admin?
  end

  def create?
    new?
  end

  def edit?
    is_super_admin?
  end

  def update?
    edit?
  end

  def show?
    is_super_admin?
  end

  def destroy?
    is_super_admin?
  end
end
