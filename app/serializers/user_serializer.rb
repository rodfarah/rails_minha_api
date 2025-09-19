class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :is_active
end
