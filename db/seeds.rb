FactoryBot.create(:user, :admin)
FactoryBot.create(:user, :with_workspaces)
FactoryBot.create(:user, :with_workspaces, :with_projects)
FactoryBot.create(:user, :with_workspaces, :with_projects, :with_comments_for_projects)
FactoryBot.create(:user, :with_workspaces, :with_projects, :with_comments_for_projects, :with_tasks)
FactoryBot.create(:user, :with_workspaces, :with_projects, :with_comments_for_projects, :with_tasks, :with_comments_for_tasks, :with_member_assignee)
FactoryBot.create(:user, :with_workspaces, :with_projects, :with_comments_for_projects, :with_tasks, :with_comments_for_tasks, :with_watchers, :with_member_assignee)

User.all.each do |user|
end
