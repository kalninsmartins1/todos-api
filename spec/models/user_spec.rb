require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  context 'validation tests' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
  end

  context 'association tests' do
    it { should have_many(:todos) }
  end
end
