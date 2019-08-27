# Class for controlling user login
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth = AuthenticateUser.new(auth_params[:email], auth_params[:password])
    if auth.valid?
      json_response(auth_token: auth.token)
    else
      json_response(message: Message.invalid_credentials)
    end
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
