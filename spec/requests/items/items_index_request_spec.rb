require 'rails_helper'

RSpec.describe 'Items index request' do
  context 'when todo exists' do
    let!(:todo) { create(:todo) }
    let!(:items) { create_list(:item, 20, todo_id: todo.id) }

    before(:each) { get todo_items_path(todo) }

    it 'returns status code :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all todo items' do
      expect(json.size).to eq(20)
    end
  end

  context 'when todo does not exist' do
    before(:each) { get todo_items_path(-1) }

    it 'returns status code :not_found' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
