require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'validation tests' do
    let!(:user) { create(:user) }
    let!(:project) { build(:project, user_id: user.id) }

    it "ensures required fields are present" do
      expect(project.valid?).to eq(true)
    end

    it "ensures the name isn't empty" do
      project.name = ''
      expect(project.valid?).to eq(false)
    end

    it "ensures length title must be less then 251" do
      project.name = '@' * 251
      expect(project.valid?).to eq false
    end
  end
end
