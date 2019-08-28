require 'rails_helper'

RSpec.describe 'Todos request versioning', type: :request do
  let(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, created_by: user.id) }

  def api_version_header(version)
    {accept: "application/vnd.todos.v#{version}+json"}
  end

  it 'responds to v1 requst' do
    get todos_path, headers: valid_headers(user.id).merge!(api_version_header(1))
    expect(response.body).to match(todos.first.title)
  end

  it 'responds to v2 request' do
    get todos_path, headers: valid_headers(user.id).merge!(api_version_header(2))
    expect(response.body).to match('Hello there')
  end
end
