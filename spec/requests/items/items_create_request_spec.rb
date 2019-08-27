require 'rails_helper'

RSpec.describe 'Items create request', type: :request do
  let!(:user) { create(:user) }
  let!(:todo) { create(:todo, created_by: user.id) }
  let(:valid_attributes) { {todo_id: todo.id, item: {name: 'Visit Narnia', done: false}} }
  let(:headers) { valid_headers(user.id) }

  context 'when request attributes are valid' do
    before(:each) { post todo_items_path(todo), params: valid_attributes, headers: headers }

    it 'returns status code :created' do
      expect(response).to have_http_status(:created)
    end
  end

  context 'when an invalid request' do
    def invalid_request(todo_id)
      parameters = {todo_id: todo_id, item: {name: '', done: false}}
      post todo_items_path(todo_id), params: parameters, headers: headers
    end

    it 'returns status code :bad_request' do
      invalid_request(todo.id)
      expect(response).to have_http_status(:bad_request)
    end

    it 'return status code :unprocessable_entity when todo not found' do
      invalid_request(-1)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns a failure message' do
      invalid_request(todo.id)
      expect(response.body).to match(/Name can't be blank/)
    end
  end
end
