require 'rails_helper'

RSpec.describe 'Users create request', type: :request do
  let(:user) { build(:user) }
  let(:valid_attributes) do
    attributes_for(:user, password: user.password)
  end

  context 'when valid request' do
    before { post signup_path, params: valid_attributes }

    it 'response code is :created' do
      expect(response).to have_http_status(:created)
    end

    it 'returns success message' do
      expect(json['message']).to match(/Account created successfully/)
    end

    it 'returns an authentication token' do
      expect(json['auth_token']).not_to be_nil
    end
  end

  context 'when invalid request' do
    before { post signup_path, params: {} }

    it 'returns status code :unprocessable_entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns failure message' do
      expect(json['message'])
        .to match(['Password can\'t be blank',
                   'Name can\'t be blank',
                   'Email can\'t be blank',
                   'Password digest can\'t be blank'])
    end
  end
end
