FactoryBot.create_list(:user, 3)

User.all.each do |user|
  FactoryBot.create_list(:workspace, 3, user: user)
end

Workspace.all.each do |workspace|
  FactoryBot.create_list(:project, 2, workspace: workspace)
end

Project.all.each do |project|
  FactoryBot.create_list(:task, 3, :future, project: project)
end

User.all.each do |user|
  user.workspaces.each do |workspace|
    workspace.projects.each do |project|
      project.update(users: [user])
      FactoryBot.create_list(:comment, 1.upto(5).to_a.sample, :for_project, user: user, commentable: project)
      project.tasks.each do |task|
        FactoryBot.create_list(:comment, 1.upto(5).to_a.sample, :for_task, user: user, commentable: task)
      end
    end
  end

  user.projects.each do |project|
    project.tasks.each do |task|
      task.update(watchers: [user]) if [true, false].sample
    end
  end
end
