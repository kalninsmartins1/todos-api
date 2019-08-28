require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let!(:user) { create(:user) }

  context 'authorize_request method' do
    context 'when auth token is passed' do
      before { allow(request).to receive(:headers).and_return(valid_headers(user.id)) }

      # private method authorize_request returns current user
      it 'sets the current user' do
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end
    end

    context 'when auth token is not passed' do
      before do
        allow(request).to receive(:headers).and_return(invalid_headers)
      end

      it 'sets current user to NullUserRecord' do
        expect(subject.instance_eval { authorize_request }).to be_kind_of(NullUserRecord)
      end
    end
  end
end
