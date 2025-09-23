class CommentSerializer < ActiveModel::Serializer
  attribute :id, key: :comment_id
  attribute :user_id, key: :commented_by_user
  attribute :body
  attribute :post_short_details

  def post_short_details
    {
      post_id: object.post.id,
      post_belongs_to_user: object.post.user.id
    }
  end
end
