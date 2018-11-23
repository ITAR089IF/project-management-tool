json.call(@project, :id, :name)
json.tasks @tasks do |task|
  json.call(task, :id, :title, :description)
end
json.comments @comments do |comment|
  json.call(comment, :body)
end
