require 'rails_helper'

RSpec.describe AuthorizeRequestParser do
  let(:user) { create(:user) }
  let(:header) { {authorization: token_generator(user.id)} }

  subject(:invalid_request_obj) { described_class.new({}) }
  subject(:request_obj) { described_class.new(header) }

  context 'parse method' do
    context 'when valid request' do
      it 'returns user object' do
        auth_hash = request_obj.parse
        expect(auth_hash[:user]).to eq(user)
      end
    end

    context 'when invalid request' do
      it 'returns NullUserRecord' do
        auth_hash = invalid_request_obj.parse
        expect(auth_hash[:user]).to be_kind_of(NullUserRecord)
      end

      context 'when token is expired' do
        let(:header) { {authorization: expired_token_generator(user.id)} }
        subject(:request_obj) { described_class.new(header) }

        it 'expired in auth hash is true' do
          auth_hash = request_obj.parse
          expect(auth_hash[:auth_expired]).to eq(true)
        end
      end

      context 'fake token' do
        let(:header) { {authorization: 'foobar'} }
        subject(:invalid_request_obj) { described_class.new(header) }

        it 'has valid in auth hash set to false' do
          auth_hash = invalid_request_obj.parse
          expect(auth_hash[:auth_valid]).to eq(false)
        end
      end
    end
  end
end
