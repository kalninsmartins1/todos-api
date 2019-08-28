module AuthSpecHelper
  def prepare_auth_headers(user_id)
    request.headers.merge!(valid_headers(user_id))
  end

  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  def expired_token_generator(user_id)
    JsonWebToken.encode({user_id: user_id}, (Time.now.to_i - 10))
  end

  def valid_headers(user_id)
    {authorization: token_generator(user_id)}
  end

  def invalid_headers
    {authorization: nil}
  end
end
