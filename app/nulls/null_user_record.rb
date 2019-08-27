# Null object pattern for user record
class NullUserRecord
  def id
    -1
  end

  def update(_params)
    false
  end

  def valid?
    false
  end

  def destroy
    false
  end
end
