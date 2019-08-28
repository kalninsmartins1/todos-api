# Class for representing auth token
class AuthToken
  attr_reader :token, :valid, :expired
  alias expired? expired
  alias valid? valid

  def initialize(token, expired, valid)
    @token = token
    @expired = expired
    @valid = valid
  end
end
