require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    let!(:user) { build(:user) }

    it "ensures required fields are present" do
      expect(user.valid?).to eq(true)
    end

    it "ensures first_name isn't empty" do
      user.first_name = ''
      expect(user.valid?).to eq(false)
    end

    it "ensures last_name isn't empty" do
      user.last_name = ''
      expect(user.valid?).to eq(false)
    end

    it "ensures length must be less then 251" do
      user.first_name = '@' * 251
      expect(user.valid?).to eq false
    end

    it "ensures length must be less then 251" do
      user.last_name = '@' * 251
      expect(user.valid?).to eq false
    end
  end
end
