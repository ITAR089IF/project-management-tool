class WorkspaceDetailsJob < ApplicationJob
  queue_as :default

  def perform(workspace_id, current_user_id)
    @user = User.find(current_user_id)
    @workspace = @user.available_workspaces.find(workspace_id)
    viewer = ActionView::Base.new()
    viewer.view_paths = ActionController::Base.view_paths

    viewer.class_eval do
      include Rails.application.routes.url_helpers
    end

    viewer.instance_variable_set(:@workspace, @workspace)
    content = viewer.render pdf: @workspace.name,
              layout: "/layouts/pdf_layout", template: "/mailers/workspaces/email_attachment",
              encoding: "UTF-8"
    file = WickedPdf.new.pdf_from_string(content)
    WorkspacesMailer.workspace_details(@workspace, @user, file).deliver_later
  end
end
