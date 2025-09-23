class CommentsController < ApplicationController
  before_action :get_comment, only: [ :show, :update, :destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /comments
  def index
    comments = Comment.all
    render json: comments
  end

  # GET /comments/:id
  def show
    render json: @comment
  end

  # POST /comments
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT ou PATCH /comments/:id
  def update
    @comment = Comment.find(params[:id])
    # Authorization
    authorize @comment

    if @comment.update(comment_params)
      render json: @comment
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /comments/:id
  def destroy
    @comment = Comment.find(params[:id])

    # Authorization
    authorize @comment
    @comment.destroy
    render json: { message: "Comment has been deleted" }
  end

  private

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    # Garante que o hash params tenha uma chave comment.
    # Permite apenas os atributos listados (:body e : user_id)
    # a serem usados no Comment.new ou @comment.update
    # Evita que alguém envie um atributo que você não quer, como
    # is_admin: true ou id: 9999.
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

  def record_not_found
    render json: { error: "Comment not found" }, status: :not_found
  end
end
