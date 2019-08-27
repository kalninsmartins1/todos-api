require 'rails_helper'

RSpec.describe 'Todos index request', type: :request do
  let!(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, created_by: user.id) }

  before(:each) { get todos_path, headers: valid_headers(user.id) }

  it 'returns todos' do
    # Note `json` is a custom helper to parse JSON responses
    expect(json).not_to be_empty
    expect(json.size).to eq(10)
  end

  it 'returns status code :ok' do
    expect(response).to have_http_status(:ok)
  end
end
