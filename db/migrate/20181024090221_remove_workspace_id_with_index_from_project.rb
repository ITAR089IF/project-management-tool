class RemoveWorkspaceIdWithIndexFromProject < ActiveRecord::Migration[5.2]
  def change
    remove_index :projects, :workspace_id
    remove_column :projects, :workspace_id, :integer
  end
end
