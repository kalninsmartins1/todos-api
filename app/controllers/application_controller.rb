# Base class for all api controllers
class ApplicationController < ActionController::API
  before_action :authorize_request
  attr_reader :current_user

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  private

  def authorize_request
    auth_hash = AuthorizeRequestParser.new(request.headers).parse
    @current_user = auth_hash[:user]
  end
end
