class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [ :create ]
  before_action :get_user, only: [ :show, :update, :destroy, :destroy_comments, :admin_update ]

  # GET /users
  def index
    users = User.all
    render json: users
  end

  # GET /users/:id
  def show
    render json: @user
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: 404
  end

  # POST /users
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT / PATCH /users/:id
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: 404
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    render json: { message: "User deleted" }
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: 404
  end

  # CUSTOMIZED ACTION to delete all comments from a specific user
  # DELETE /users/:id/comments
  def destroy_comments
    @user.comments.destroy_all
    render json: { message: "All comments from this user have been deleted successfully" }
  end

  # PUT / PATCH /users/:id/admin_update
  # Esse endpoint é específico para admins alterarem usuários, inclusive atributos sensíveis (role e is_active).
  def admin_update
    authorize @user, :admin_update? # Pundit only let admin access
    if @user.update(admin_user_params)
      render json: @user, serializer: AdminUserUpdateSerializer
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :email, :gender)
  end

  def admin_user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :email, :gender, :role, :is_active)
  end

  def get_user
    @user = User.find(params[:id])
  end
end
