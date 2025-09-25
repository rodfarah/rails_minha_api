class LikePolicy < ApplicationPolicy
  
  def index?
    active_and_present_user? && user.admin?
  end
  
  def destroy?
    active_and_present_user? && (user.admin? || user.id == record.user_id)
  end
  
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.none
      end
    end
  end
end