require 'rails_helper'

RSpec.describe Comment, type: :model do

  context 'factory tests for projects comment' do
    subject { build(:comment, :for_project) }
    it { is_expected.to be_valid }
  end

  context 'factory tests for tasks comment' do
    subject { build(:comment, :for_task) }
    it { is_expected.to be_valid }
  end
end
