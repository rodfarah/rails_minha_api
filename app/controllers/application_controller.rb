class ApplicationController < ActionController::API
  include Pundit::Authorization
  before_action :authorize_request
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  attr_reader :current_user

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header

    decoded = JsonWebToken.decode(token)

    if decoded
      @current_user = User.find_by(id: decoded[:user_id])
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def user_not_authorized(exception)
    render json: {
      error: "You do not have authorization to perform this action.",
        policy: exception.policy.class.to_s,
        query: exception.query
        }, status: :forbidden
  end
end
