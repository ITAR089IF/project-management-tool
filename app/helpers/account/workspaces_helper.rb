module Account::WorkspacesHelper
  def uninvited_users(workspace)
    ids = workspace.members.ids << workspace.user.id
    User.where.not(id: ids)
  end
end
