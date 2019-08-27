require 'rails_helper'

RSpec.describe 'Items destroy request' do
  let!(:user) { create(:user) }
  let!(:todo) { create(:todo, created_by: user.id) }

  context 'valid request' do
    let!(:item) { create(:item, todo_id: todo.id) }

    it 'returns status code :no_content' do
      delete todo_item_path(todo, item), headers: valid_headers(user.id)
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'invalid request' do
    it 'returns status code :unprocessable_entity' do
      delete todo_item_path(todo, -1), headers: valid_headers(user.id)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
