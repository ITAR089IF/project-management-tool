class MembersMailer < ApplicationMailer
  default template_path: 'mailers/members'

  def member_added(member, workspace, current_user)
    @member = member
    @user = current_user
    @workspace = workspace
    mail(
      to: @member.email,
      subject: "You have been added to the workspace"
    )
  end
end
