require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'factory tests' do
    subject { build(:project) }
    it { is_expected.to be_valid } 
  end

  context 'validation tests' do
    it { should validate_presence_of(:name) }

    it { should belong_to(:user) }

    it { should have_many(:tasks) }

    it { should validate_length_of(:name).is_at_most(250) }
  end
end
