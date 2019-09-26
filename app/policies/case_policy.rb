class CasePolicy < ControllersPolicy
  def index?
    is_super_admin? || is_asesor?
  end
end
