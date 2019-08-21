# Todo model decorator for always returning valid value
class ValidTodoDecorator
  def self.find(id)
    Todo.find(id)
  rescue ActiveRecord::RecordNotFound
    NullTodoRecord.new
  end
end
