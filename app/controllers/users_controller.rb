class UsersController < ApplicationController
  before_action :get_user, only: [ :show, :update, :destroy, :destroy_comments ]

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

  private

  def user_params
    params.require(:user).permit(:name, :email, :gender, :is_active)
  end

  def get_user
    @user = User.find(params[:id])
  end
end
