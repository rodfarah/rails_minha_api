class LikesController < ApplicationController
  before_action :set_likeable
  before_action :set_like, only: [:create, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
 
  # POST /posts/:post_id/likes
  # POST /posts/:post_id/comments/:comment_id/likes
   def create
    if @like
      render json: { error: "You have already liked this" }, status: :unprocessable_entity
    else
      @like = @likeable.likes.new(user: @current_user)

      if @like.save
        render json: @like, status: :created
      else
        render json: { errors: @like.errors.full_messages }, status: :unprocessable_entity
      end 
    end
  end

  # DELETE /posts/:post_id/likes/:id
  # DELETE /posts/:post_id/comments/:comment_id/likes/:id
  def destroy
    if @like
      authorize @like
      @like.destroy
      render json: { message: "Like has been removed successfully" }, status: :ok
    else
      render json: { error: "Like not found" }, status: :not_found
    end
  end

  # GET /posts/:post_id/likes
  # GET /posts/:post_id/comments/:comment_id/likes
  # def index
  #   authorize Like
  #   likes = @likeable.likes
  #   render json: likes, status: :ok
  # end

  def index
  Rails.logger.debug "Current user: #{current_user.inspect}"
  authorize Like
  likes = @likeable.likes
  render json: likes, status: :ok
  end

  private

  # Localiza o "likeable", que pode ser um Post ou um Comment.
  def set_likeable
    if params[:comment_id]
      post = Post.find(params[:post_id])
      @likeable = post.comments.find(params[:comment_id])
    else
      @likeable = Post.find(params[:post_id])
    end
  end

  # Localiza o like associado ao usuário atual, caso exista.
  # Usado no destroy para garantir que estamos agindo sobre o like correto.
  def set_like
    @like = @likeable.likes.find_by(user: @current_user)
  end

  def record_not_found
    render json: { error: "Like not found" }, status: :not_found
  end
end