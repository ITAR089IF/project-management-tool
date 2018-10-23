FactoryBot.create_list(:user, 3)

User.all.each do |user|
  3.times do
    FactoryBot.create(:workspace, user_id: user.id)
  end
end

Workspace.all.each do |workspace|
  3.times do
    FactoryBot.create(:project, workspace_id: workspace.id)
  end
end

Project.all.each do |project|
  3.times do
    FactoryBot.create(:task, project_id: project.id)
  end
end
