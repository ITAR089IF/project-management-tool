class WorkspacesMailer < ApplicationMailer
  default template_path: 'mailers/workspaces'

  def workspace_details(workspace, current_user, file)
    @workspace = workspace
    @user = current_user
    attachments["#{@workspace.name}.pdf"] = file
    mail(
      to: @user.email,
      subject: "You have been received workspace details"
    )
  end
end
