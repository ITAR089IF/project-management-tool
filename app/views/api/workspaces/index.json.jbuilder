json.workspaces @workspaces do |workspace|
  json.call(workspace, :id, :name)
end
