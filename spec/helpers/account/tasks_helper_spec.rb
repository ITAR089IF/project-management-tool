require 'rails_helper'

RSpec.describe Account::TasksHelper, type: :helper do
  let!(:user)         { create(:user) }
  let!(:workspace)    { create(:workspace, user: user) }
  let!(:project)      { create(:project, workspace: workspace, users: [user]) }
  let!(:section)      { create(:task, project: project, section: true) }
  let!(:expired_task) { create(:task, :expired, project: project) }
  let!(:task)         { create(:task, project: project) }

  describe "#task_link_class" do
    it "returns classes for section" do
      expect(helper.task_link_class(section)).to eq('title is-4 is-italic')
    end

    it "returns classes for expired task" do
      expect(helper.task_link_class(expired_task)).to eq("has-text-danger")
    end

    it "returns classes for link" do
      expect(helper.task_link_class(task)).to eq("has-text-link")
    end
  end
  
end
