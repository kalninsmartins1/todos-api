# Item model decorator for ensuring valid value
class ValidItemDecorator
  def self.find(id)
    Item.find(id)
  rescue ActiveRecord::RecordNotFound
    NullItemRecord.new
  end

  def self.find_in_array(array, id)
    array.find(id)
  rescue ActiveRecord::RecordNotFound
    NullItemRecord.new
  end
end
