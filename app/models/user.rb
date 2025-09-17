class User < ApplicationRecord
  # enum for gender
  enum :gender, { male: 0, female: 1, other: 2 }

  # basic validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
