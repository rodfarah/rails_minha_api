class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy # on_delete(Model.Cascade) do Django
  # enum for gender
  enum :gender, { male: 0, female: 1, other: 2 }

  # enum for role
  enum :role, { admin: 0, user: 1 }

  # basic validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def is_admin?
    role == "admin"
  end
end
