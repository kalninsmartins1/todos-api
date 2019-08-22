require 'rails_helper'

RSpec.describe 'Items destroy request' do
  let!(:todo) { create(:todo) }

  context 'valid request' do
    let!(:item) { create(:item, todo_id: todo.id) }

    it 'returns status code :no_content' do
      delete todo_item_path(todo, item)
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'invalid request' do
    it 'returns status code :not_found' do
      delete todo_item_path(todo, -1)
      expect(response).to have_http_status(:not_found)
    end
  end
end
