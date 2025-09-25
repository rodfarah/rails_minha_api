class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true
  validate :post_id_can_not_change

  private

  def post_id_can_not_change
    if persisted? && will_save_change_to_post_id?
      errors.add(:base, "A comment belongs to the original and specific post")
    end
  end
end
