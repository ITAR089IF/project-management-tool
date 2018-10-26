# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  oauth_expires_at       :string
#  oauth_token            :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) {create :user, first_name: 'John', last_name: 'Doe'}
  it 'returns full name' do
    it {expect(user.full_name).to eq 'John Dou'}

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
