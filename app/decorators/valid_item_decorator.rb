# Item model decorator for always returning valid value
class ValidItemDecorator
  def self.find(id)
    Item.find(id)
  rescue ActiveRecord::RecordNotFound
    NullItemRecord.new
  end
end
