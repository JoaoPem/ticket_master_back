class ApplicationController < ActionController::API
  before_action :ensure_json_request
  before_action :authenticate

  rescue_from JWT::VerificationError, with: :invalid_token
  rescue_from JWT::DecodeError, with: :decode_error

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  rescue_from CanCan::AccessDenied, with: :access_denied

  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  attr_reader :current_user

  def route_not_found
    render json: { error: "Route not found" }, status: :not_found
  end

  private

  def authenticate
    authorization_header = request.headers["Authorization"]
    token = authorization_header.split(" ").last if authorization_header
    decoded_token = JsonWebToken.decode(token)

    @current_user = User.find(decoded_token[:user_id])
  end

  def invalid_token
    render json: { invalid_token: "Invalid token" }
  end

  def decode_error
    render json: { decode_error: "You must be logged in" }
  end

  def record_not_found
    render json: { error: "ID not found" }, status: :not_found
  end

  def ensure_json_request
    unless request.headers["Accept"].to_s.include?("application/vnd.api+json")
      render json: { error: "Unsupported Media Type. Only application/vnd.api+json is allowed." }, status: :unsupported_media_type
      nil
    end
  end

  def access_denied
    render json: { error: "Access Denied: You do not have permission to perform this action." }, status: :forbidden
  end

  def parameter_missing(exception)
    render json: { error: exception.message }, status: :bad_request
  end
end
