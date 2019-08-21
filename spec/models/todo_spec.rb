require 'rails_helper'

RSpec.describe Todo, type: :model do
  context 'validation tests' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:created_by) }
  end

  context 'association tests' do
    it { should have_many(:items).dependent(:destroy) }
  end
end
