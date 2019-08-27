# Null object pattern for todo record
class NullTodoRecord
  def id
    -1
  end

  def update(_params)
    false
  end

  def destroy
    false
  end

  def valid?
    false
  end

  def items
    create = Struct.new(:null) do
      def create(_arg)
        NullItemRecord.new
      end
    end

    create.new
  end

  def errors
    NullTodoErrors.new
  end
end
