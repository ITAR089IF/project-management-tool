require 'rails_helper'

RSpec.describe CommentsHelper, type: :helper do

  describe '.can_manage_comment?' do
    let(:current_user) { create :user }
    let(:project) { create :project}
    let(:comment) { create :project_comment, user: current_user, commentable: project}

    before { allow(helper).to receive(:current_user).and_return(current_user) }

    context 'current_user comment' do
      it { expect(can_manage_comment?(comment)).to be true }
    end

    context 'another_user comment' do
      let(:another_user) { create :user }
      let(:comment) { create :project_comment, user: another_user, commentable: project }

      it { expect(can_manage_comment?(comment)).to be false }
    end
  end
end
