require 'rails_helper'

RSpec.describe 'Todos show request', type: :request do
  context 'when the record exists' do
    let(:todo) { create(:todo) }

    before(:each) { get todo_path(todo) }

    it 'returns the todo' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(todo.id)
    end

    it 'returns status code :ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when the record does not exist' do
    before(:each) { get todo_path(-1) }

    it 'returns status code :not_found' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
