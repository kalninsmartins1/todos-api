# Class for handling user authentication
class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def valid?
    user.valid? && user.authenticate(password)
  end

  def token
    return JsonWebToken.encode(user_id: user.id) if valid?
  end

  private

  attr_reader :email, :password
  attr_writer :user

  def user
    @user ||= ValidUserDecorator.find_by(email: email)
  end
end
