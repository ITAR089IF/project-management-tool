json.call(@project, :id, :name) 
json.tasks @tasks, :id, :title
json.comments @comments, :id, :body
