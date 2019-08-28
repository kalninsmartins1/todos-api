# Class for representing JWT token
class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    # set expiry to 24 hours from creation time
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET)[0]
    token = HashWithIndifferentAccess.new(body)
    AuthToken.new(token, false, true)
  rescue JWT::ExpiredSignature
    AuthToken.new(token, true, false)
  rescue JWT::DecodeError
    AuthToken.new(token, false, false)
  end
end
