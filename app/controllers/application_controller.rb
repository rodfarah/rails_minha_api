# class ApplicationController < ActionController::API
#   before_action :authorize_request

#   private

#   def authorize_request
#     header = request.headers["Authorization"]
#     token = header.split(" ").last if header

#     @decoded = JsonWebToken.decode(token)
#     unless @decoded
#       render json: { error: "Unauthorized" }, status: :unauthorized
#     end
#   end
# end

class ApplicationController < ActionController::API
  before_action :authorize_request

  private

  def authorize_request
    header = request.headers["Authorization"]
    Rails.logger.info "HEADER RAW: #{header.inspect}"

    token = header.split(" ").last if header
    Rails.logger.info "TOKEN EXTRAÍDO: #{token.inspect}"

    @decoded = JsonWebToken.decode(token)
    Rails.logger.info "DECODED: #{@decoded.inspect}"

    unless @decoded
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
