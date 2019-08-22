require 'rails_helper'

RSpec.describe 'Items create request' do
  let(:todo) { create(:todo) }
  let(:valid_attributes) { {item: {name: 'Visit Narnia', done: false}} }

  context 'when request attributes are valid' do
    before(:each) { post todo_items_path(todo), params: valid_attributes }

    it 'returns status code :created' do
      expect(response).to have_http_status(:created)
    end
  end

  context 'when an invalid request' do
    before(:each) { post todo_items_path(todo), params: {item: {name: '', done: false}} }

    it 'returns status code :bad_request' do
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns a failure message' do
      expect(response.body).to match(/Name can't be blank/)
    end
  end
end
