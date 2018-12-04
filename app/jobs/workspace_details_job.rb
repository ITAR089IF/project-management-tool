class WorkspaceDetailsJob < ApplicationJob
  queue_as :default

  def perform(workspace_id, current_user_id)
    @workspace = Workspace.find(workspace_id)
    @user = User.find(current_user_id)
    av = ActionView::Base.new()
    av.view_paths = ActionController::Base.view_paths

    av.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
    end
    
    av.instance_variable_set(:@workspace, @workspace)
    content = av.render pdf: @workspace.name, 
              layout: "/layouts/pdf_layout", template: "/mailers/workspaces/email_attachment",
              encoding: "UTF-8"
    file = WickedPdf.new.pdf_from_string(content)
    WorkspacesMailer.workspace_details(@workspace, @user, file).deliver_later
  end
end
