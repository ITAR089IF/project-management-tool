FactoryBot.create_list(:user, 3)

User.all.each do |user|
  FactoryBot.create_list(:workspace, 3, user: user)
end

Workspace.all.each do |workspace|
  FactoryBot.create_list(:project, 2, workspace: workspace)
end

Project.all.each do |project|
  FactoryBot.create_list(:task, 3, project: project)
end

User.all.each do |user|
  projects = []

  user.workspaces.each do |workspace|
    workspace.projects.each do |project|
      projects << project
      FactoryBot.create_list(:comment, [*3..5].sample, :for_project, user: user, commentable: project)
      project.tasks.each do |task|
        FactoryBot.create_list(:comment, [*3..5].sample, :for_task, user: user, commentable: task)
      end
    end
  end
  user.update(projects: projects)
end
