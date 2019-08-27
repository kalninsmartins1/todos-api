# Null object pattern for todo record
class NullItemRecord
  def id
    -1
  end

  def update(_params)
    false
  end

  def save
    false
  end

  def destroy
    false
  end

  def valid?
    false
  end

  def errors
    NullItemErrors.new
  end
end
