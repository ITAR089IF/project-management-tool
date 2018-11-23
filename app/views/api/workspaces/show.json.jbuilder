json.call(@workspace, :id, :name) do
  json.members @members, :id, :first_name, :last_name, :email
end
