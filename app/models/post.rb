class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, unless: :draft?
  validates :body, length: { minimum: 2, maximum: 500 }, allow_blank: true

  # convenience methods
  def published?
    !draft?
  end

  def publish!
    update!(draft: false)
  end
end
