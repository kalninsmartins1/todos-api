# Class for making sure request is made from authorized user
class AuthorizeRequestParser
  def initialize(headers = {})
    @headers = headers
  end

  def parse
    {user: user}
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => e
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
    )
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return headers[:authorization].split(' ').last if headers[:authorization].present?

    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
