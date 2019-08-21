require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'validation tests' do
    it { should validate_presence_of(:name) }
  end

  context 'association tests' do
    it { should belong_to(:todo) }
  end
end
