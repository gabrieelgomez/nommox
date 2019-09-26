class CaseStatusPolicy < ControllersPolicy
  def index?
    is_super_admin?
  end
end
