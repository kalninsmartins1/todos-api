require 'rails_helper'

RSpec.describe 'Todos create request', type: :request do
  let(:todo) { build(:todo) }
  let(:valid_attributes) { {todo: {title: todo.title, created_by: todo.created_by}} }

  context 'when the request is valid' do
    before(:each) { post todos_path, params: valid_attributes }

    it 'creates a todo' do
      expect(json['title']).to eq(todo.title)
    end

    it 'returns status code :created' do
      expect(response).to have_http_status(:created)
    end
  end

  context 'invalid request' do
    before(:each) { post todos_path, params: {todo: {title: todo.title}} }

    it 'returns status code :bad_request' do
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns a validation failure message' do
      expect(response.body).to match(/Created by can't be blank/)
    end
  end
end
