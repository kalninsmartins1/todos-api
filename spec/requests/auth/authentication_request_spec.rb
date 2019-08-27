require 'rails_helper'

RSpec.describe 'Authentication request', type: :request do
  let!(:user) { create(:user) }
  let(:valid_credentials) do
    {
      email: user.email,
      password: user.password
    }
  end
  let(:invalid_credentials) do
    {
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }
  end

  context 'when request is valid' do
    before { post auth_path, params: valid_credentials }

    it 'returns an authentication token' do
      expect(json['auth_token']).not_to be_nil
    end
  end

  context 'When request is invalid' do
    before { post auth_path, params: invalid_credentials, headers: headers }

    it 'returns a failure message' do
      expect(json['message']).to match(/Invalid credentials/)
    end
  end
end
