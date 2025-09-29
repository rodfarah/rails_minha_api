class PostsController < ApplicationController
  before_action :get_post, only: [ :show, :update, :destroy ]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /posts
  def index
    # Only admin may see all posts. User may see self created posts.
    posts = policy_scope(Post)
    render json: posts
  end

  # GET /posts/:id
  def show
    authorize @post
    render json: @post
  end

  # POST /posts
  def create
    post = Post.new(post_params)
    # Authorization
    authorize post
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT / PATCH /posts/:id
  def update
    # authorization
    authorize @post

    if @post.update(post_params)
      render json: @post
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:id
  def destroy
    authorize @post

    @post.destroy
    render json: { message: "Post has been deleted successfully" }
  end

  private

  def get_post
    @post = Post.find(params[:id])
  end

  def record_not_found
    render json: { error: "Post not found" }, status: :not_found
  end

  def post_params
    # Garante que o hash params tenha uma chave post.
    # Permite apenas os atributos listados (:title, :body e :user_id)
    # a serem usados no Post.new ou @post.update
    # Evita que alguém envie um atributo que você não quer, como
    # is_admin: true ou id: 9999.
    params.require(:post).permit(:title, :body, :draft, :user_id)
  end
end
