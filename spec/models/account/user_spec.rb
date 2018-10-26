require 'rails_helper'

RSpec.describe User, type: :model do
  context 'factory tests' do
    subject { build(:user) }
    it { is_expected.to be_valid } 
  end

  context 'validation tests' do
    it { should validate_presence_of(:first_name) }

    it { should validate_presence_of(:last_name) }

    it { should have_many(:projects) }
 
    it { should validate_length_of(:first_name).is_at_most(250) }

    it { should validate_length_of(:last_name).is_at_most(250) }
  end
end
