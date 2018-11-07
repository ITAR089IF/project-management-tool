class AddDeletedAtToWorkspaces < ActiveRecord::Migration[5.2]
  def change
    add_column :workspaces, :deleted_at, :datetime
    add_index :workspaces, :deleted_at
  end
end
