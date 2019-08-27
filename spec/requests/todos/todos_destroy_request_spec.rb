require 'rails_helper'

RSpec.describe 'Todos destroy request', type: :request do
  let!(:user) { create(:user) }

  context 'valid request' do
    let(:todo) { create(:todo, created_by: user.id) }

    before(:each) { delete todo_path(todo), headers: valid_headers(user.id) }

    it 'returns status code :no_content' do
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'invalid request' do
    before(:each) { delete todo_path(-1), headers: valid_headers(user.id) }

    it 'returns status code :unprocessable_entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
