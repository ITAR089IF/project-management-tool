require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'validation tests' do
    let!(:user) { create(:user) }
    let!(:project) { build(:project, user_id: user.id) }

    it { should validate_presence_of(:name) }

    it { should belong_to(:user) }

    it { should have_many(:tasks) }

    it { should validate_length_of(:name).is_at_most(250) }

  end
end
