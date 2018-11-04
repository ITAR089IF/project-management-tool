require 'rails_helper'

RSpec.describe Comment, type: :model do

  context 'factories' do
  it { expect(build(:comment, :for_project)).to be_valid }
  it { expect(build(:comment, :for_task)).to be_valid }
  end
end
