class AddWorkspaceRefToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :workspace, foreign_key: true
  end
end
