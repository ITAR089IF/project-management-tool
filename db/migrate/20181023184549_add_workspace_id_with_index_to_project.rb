class AddWorkspaceIdWithIndexToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :workspace_id, :integer
    add_index :projects, :workspace_id
  end
end
