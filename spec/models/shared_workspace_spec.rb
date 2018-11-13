require 'rails_helper'

RSpec.describe SharedWorkspace, type: :model do
  context 'factory tests' do
    subject { build(:shared_workspace) }
    it { is_expected.to be_valid }
  end
end
