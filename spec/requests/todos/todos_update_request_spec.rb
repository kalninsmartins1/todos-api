require 'rails_helper'

RSpec.describe 'Todos update request', type: :request do
  let(:user) { create(:user) }

  context 'when todo exists' do
    let!(:todo) { create(:todo, created_by: user.id) }
    let(:new_todo) { build(:todo) }

    before(:each) { patch todo_path(todo), params: {todo: {title: new_todo.title}}, headers: valid_headers(user.id) }

    it 'todo title is updated' do
      todo.reload
      expect(todo.title).to eq(new_todo.title)
    end

    it 'returns status code :ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when todo does not exists' do
    before(:each) { patch todo_path(-1), params: {todo: {title: ''}}, headers: valid_headers(user.id) }

    it 'returns status code :bad_request' do
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns a null record error message' do
      expect(response.body).to match(NullTodoErrors.new.full_messages)
    end
  end
end
