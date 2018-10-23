class RemoveWorkspaceIdFromProject < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :workspace_id, :integer
  end
end
