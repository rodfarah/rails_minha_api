class UserPolicy < ApplicationPolicy
  def update?
    user.present? && user.is_active? && (user.id == record.id)
  end

  def admin_update?
    user.present? && user.admin?
  end
end