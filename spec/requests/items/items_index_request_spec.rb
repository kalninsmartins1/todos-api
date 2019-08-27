require 'rails_helper'

RSpec.describe 'Items index request' do
  let!(:user) { create(:user) }

  context 'when todo exists' do
    let!(:todo) { create(:todo, created_by: user.id) }
    let!(:items) { create_list(:item, 20, todo_id: todo.id) }

    before(:each) { get todo_items_path(todo), headers: valid_headers(user.id) }

    it 'returns status code :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all todo items' do
      expect(json.size).to eq(20)
    end
  end

  context 'when todo does not exist' do
    before(:each) { get todo_items_path(-1), headers: valid_headers(user.id) }

    it 'returns status code :unprocessable_entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
