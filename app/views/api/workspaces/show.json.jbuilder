json.call(@workspace, :id, :name)
json.members @members do |member|
  json.call(member, :id, :first_name, :last_name, :email)
end
