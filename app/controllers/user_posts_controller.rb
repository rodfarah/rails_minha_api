class UserPostsController < ApplicationController
  before_action :set_user

  def index
    # regra para admin
    if @current_user.is_admin? || @current_user == @user
      posts = @user.posts
    else
      posts = @user.posts.where(draft: false)
    end
    
    render json: posts
  end
  
  private
  def set_user
    @user = User.find(params[:user_id])
  end
end
