class PostPolicy < ApplicationPolicy
  def update?
    user.admin? || user.id == record.user.id
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
