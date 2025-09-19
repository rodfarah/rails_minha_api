class PostSerializer < ActiveModel::Serializer
  # these will be sent in JSON
  attributes :id, :title, :body, :user_id, :short_comment_details

  def short_comment_details
    object.comments.map do |comment|
      { comment_id: comment.id, commented_by_user: comment.user.id, body: comment.body }
    end
  end
end
