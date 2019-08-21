# Null object pattern for todo record
class NullItemRecord
  def id
    -1
  end

  def update(_params)
    false
  end

  def destroy
    false
  end
end
