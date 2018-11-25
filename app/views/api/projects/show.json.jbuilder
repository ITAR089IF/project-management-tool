json.call(@project, :id, :name)
json.tasks @project.tasks, :id, :title, :completed_at
json.comments @project.comments, :id, :body
