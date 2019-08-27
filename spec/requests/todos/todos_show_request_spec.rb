require 'rails_helper'

RSpec.describe 'Todos show request', type: :request do
  let!(:user) { create(:user) }

  context 'when the record exists' do
    let(:todo) { create(:todo, created_by: user.id) }

    before(:each) { get todo_path(todo), headers: valid_headers(user.id) }

    it 'returns the todo' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(todo.id)
    end

    it 'returns status code :ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when the record does not exist' do
    before(:each) { get todo_path(-1), headers: valid_headers(user.id) }

    it 'returns status code :unprocessable_entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
