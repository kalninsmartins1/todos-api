# User model decorator for ensuring valid value
class ValidUserDecorator
  def self.find(id)
    User.find(id)
  rescue ActiveRecord::RecordNotFound
    NullUserRecord.new
  end

  def self.find_by(hash)
    User.find_by(hash) || NullUserRecord.new
  end
end
