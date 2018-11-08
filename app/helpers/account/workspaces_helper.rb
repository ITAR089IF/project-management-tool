module Account::WorkspacesHelper
  def uninvited_users(workspace)
    uninvited = User.all.select do |person|
      next if person == workspace.user
      workspace.members.exclude?(person)
    end
  end
end
