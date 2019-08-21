# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  context 'GET /todos' do
    # make HTTP get request before each example
    before { get todos_path }

    it 'returns todos' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'GET /todos/:id' do
    before { get todo_path(todo_id) }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  context 'POST /todos' do
    # valid payload
    let(:valid_attributes) { {todo: {title: 'Learn Elm', created_by: '1'}} }

    context 'when the request is valid' do
      before { post todos_path, params: valid_attributes }

      it 'creates a todo' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'invalid request' do
      before { post todos_path, params: {todo: {title: 'Foobar'}} }

      it 'returns status code 400 bad request' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Created by can't be blank/)
      end
    end
  end

  context 'PATCH /todos/:id' do
    let(:valid_attributes) { {todo: {title: 'Shopping'}} }

    context 'when the record exists' do
      before { put todo_path(todo_id), params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  context 'DELETE /todos/:id' do
    before { delete todo_path(todo_id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
