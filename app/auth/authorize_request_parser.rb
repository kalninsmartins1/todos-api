# Class for making sure request is made from authorized user
class AuthorizeRequestParser
  def initialize(headers = {})
    @headers = headers
  end

  def parse
    {
      user: user,
      auth_valid: decoded_auth_token.valid?,
      auth_expired: decoded_auth_token.expired?
    }
  end

  private

  attr_reader :headers

  def user
    if decoded_auth_token.valid?
      @user ||= ValidUserDecorator.find(decoded_auth_token.token[:user_id])
    else
      NullUserRecord.new
    end
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return headers[:authorization].split(' ').last if headers[:authorization].present?
  end
end
