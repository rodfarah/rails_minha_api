class CommentPolicy < ApplicationPolicy
  def update?
    user.admin? || record.user.id == user.id
  end

  def edit
    update?
  end

  def destroy?
    update?
  end
end
