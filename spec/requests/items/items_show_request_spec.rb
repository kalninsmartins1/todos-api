require 'rails_helper'

RSpec.describe 'Items show request' do
  let(:user) { create(:user) }
  let(:todo) { create(:todo, created_by: user.id) }

  context 'when item exists' do
    let(:item) { create(:item, todo_id: todo.id) }

    before(:each) { get todo_item_path(todo, item), headers: valid_headers(user.id) }

    it 'returns status code :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the item' do
      expect(json['id']).to eq(item.id)
    end
  end

  context 'when item does not exist' do
    before(:each) { get todo_item_path(todo, -1), headers: valid_headers(user.id) }

    it 'returns status code :unprocessable_entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
