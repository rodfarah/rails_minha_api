class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
  
  def index?
    active_and_present_user?
  end

  def show?
    active_and_present_user?
  end

  def create?
    active_and_present_user?
  end

  def update?
    active_and_present_user? &&
      (user.admin? || record.user_id == user.id)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
