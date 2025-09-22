class AuthController < ApplicationController
  skip_before_action :authorize_request, only: [ :login ]

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id, role: @user.role)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Unvalid username or password" }, status: :unauthorized
    end
  end
end
