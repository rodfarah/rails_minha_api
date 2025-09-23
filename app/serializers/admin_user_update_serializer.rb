class AdminUserUpdateSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :message

  def message
    "User updated successfully"
  end
end