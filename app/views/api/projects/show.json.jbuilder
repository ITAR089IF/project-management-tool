json.call(@project, :id, :name) do
  json.tasks @tasks, :id, :title
  json.comments @comments, :id, :body
end
