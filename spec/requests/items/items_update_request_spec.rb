require 'rails_helper'

RSpec.describe 'Items update request' do
  let(:todo) { create(:todo) }
  let(:valid_attributes) { {item: {name: 'Mozart'}} }

  context 'when item exists' do
    let(:item) { create(:item, todo_id: todo.id) }

    before(:each) { patch todo_item_path(todo, item), params: valid_attributes }

    it 'returns status code :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'item gets updated' do
      updated_item = ValidItemDecorator.find(item.id)
      expect(updated_item.name).to match(/Mozart/)
    end
  end

  context 'when the item does not exist' do
    before(:each) { patch todo_item_path(todo, -1), params: valid_attributes }

    it 'returns status code :bad_request' do
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns a not found message' do
      expect(response.body).to match(NullItemErrors.new.full_messages)
    end
  end
end
