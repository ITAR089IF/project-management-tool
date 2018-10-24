require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'validation tests' do
    let!(:user) { create(:user) }
    let!(:project) { create(:project, user_id: user.id) }
    let!(:task) { build(:task, project_id: project.id) }

    it "ensures required fields are present" do
      expect(task.valid?).to eq(true)
    end

    it "ensures the title isn't empty" do
      task.title = ''
      expect(task.valid?).to eq(false)
    end

    it "ensures the description isn't empty" do
      task.description = ''
      expect(task.valid?).to eq(false)
    end
    
    it "ensures length title must be less then 251" do
      task.title = '@' * 251
      expect(task.valid?).to eq false
    end

    it "ensures length description must be less then 251" do
      task.description = '@' * 251
      expect(task.valid?).to eq false
    end
  end
end
