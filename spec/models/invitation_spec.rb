# == Schema Information
#
# Table name: invitations
#
#  id           :bigint(8)        not null, primary key
#  token        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  invitor_id   :integer
#  workspace_id :integer
#

require 'rails_helper'

RSpec.describe Invitation, type: :model do

  context 'factory tests' do
    subject { build(:invitation) }
    it { is_expected.to be_valid }
  end
end
