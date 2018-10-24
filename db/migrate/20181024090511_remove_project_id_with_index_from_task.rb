class RemoveProjectIdWithIndexFromTask < ActiveRecord::Migration[5.2]
  def change
    remove_index :tasks, :project_id
    remove_column :tasks, :project_id, :integer
  end
end
