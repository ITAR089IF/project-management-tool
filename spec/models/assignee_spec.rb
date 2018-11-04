require 'rails_helper'

RSpec.describe Assignee, type: :model do
  context 'factory tests' do
    subject { build(:assignee) }
    it { is_expected.to be_valid }
  end
end
