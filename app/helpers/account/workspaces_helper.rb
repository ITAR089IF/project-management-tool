module Account::WorkspacesHelper
  def uninvited_users(workspace)
    ids = [workspace.user.id]
    ids += workspace.members.ids
    User.where.not(id: ids)
  end
end
