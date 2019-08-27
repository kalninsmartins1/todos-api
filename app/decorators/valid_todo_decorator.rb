# Todo model decorator for ensuring valid value
class ValidTodoDecorator
  def self.find(id)
    Todo.find(id)
  rescue ActiveRecord::RecordNotFound
    NullTodoRecord.new
  end

  def self.find_in_array(array, id)
    array.find(id)
  rescue ActiveRecord::RecordNotFound
    NullTodoRecord.new
  end
end
