require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'factory tests' do
    subject { build(:task) }
    it { is_expected.to be_valid } 
  end

  context 'validation tests' do
    it { should validate_presence_of(:title) }

    it { should validate_presence_of(:description) }

    it { should belong_to(:project) }
 
    it { should validate_length_of(:title).is_at_most(250) }

    it { should validate_length_of(:description).is_at_most(250) }
  end
end
