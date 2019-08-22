require 'rails_helper'

RSpec.describe 'Items show request' do
  let(:todo) { create(:todo) }

  context 'when item exists' do
    let(:item) { create(:item, todo_id: todo.id) }

    before(:each) { get todo_item_path(todo, item) }

    it 'returns status code :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the item' do
      expect(json['id']).to eq(item.id)
    end
  end

  context 'when item does not exist' do
    before(:each) { get todo_item_path(todo, -1) }

    it 'returns status code :not_found' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
