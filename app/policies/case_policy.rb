class CasePolicy < ControllersPolicy
  def index?
    is_super_admin? || is_asesor?
  end

  def show?
    is_super_admin? || is_asesor?
  end

  def destroy?
    is_super_admin? || is_asesor?
  end
end
