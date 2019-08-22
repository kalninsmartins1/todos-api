require 'rails_helper'

RSpec.describe 'Todos destroy request', type: :request do
  context 'valid request' do
    let(:todo) { create(:todo) }

    before(:each) { delete todo_path(todo) }

    it 'returns status code :no_content' do
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'invalid request' do
    before(:each) { delete todo_path(-1) }

    it 'returns status code :not_found' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
