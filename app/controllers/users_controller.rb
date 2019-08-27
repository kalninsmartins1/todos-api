# Class for controlling user sign up
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create]

  def create
    user = User.create(user_params)
    auth = AuthenticateUser.new(user.email, user.password)

    if auth.valid?
      response = {message: Message.account_created, auth_token: auth.token}
      json_response(response, :created)
    else
      json_response({message: user.errors.full_messages}, :unprocessable_entity)
    end
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
