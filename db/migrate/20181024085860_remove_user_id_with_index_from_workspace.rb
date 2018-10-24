class RemoveUserIdWithIndexFromWorkspace < ActiveRecord::Migration[5.2]
  def change
    remove_index :workspaces, :user_id
    remove_column :workspaces, :user_id, :integer
  end
end
