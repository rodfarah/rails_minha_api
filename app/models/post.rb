class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, :body, presence: true
  validates :body, length: { minimum: 2, maximum: 500 }
end
