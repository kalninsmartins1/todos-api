# Base class for all api controllers
class ApplicationController < ActionController::API
  include Response

  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    user_hash = AuthorizeRequestParser.new(request.headers).parse
    @current_user = user_hash[:user]
  end
end
