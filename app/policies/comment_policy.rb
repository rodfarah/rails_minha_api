class CommentPolicy < ApplicationPolicy
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
    active_and_present_user? && (user.admin? || record.user_id == user.id)
  end

  def edit?
    update?
  end

  def destroy?
    active_and_present_user? &&
      (user.admin? || record.post.user_id == user.id || record.user_id == user.id)
  end
end
