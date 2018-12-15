json.call(@workspace, :id, :name)
json.members @workspace.members, :id, :first_name, :last_name, :email
