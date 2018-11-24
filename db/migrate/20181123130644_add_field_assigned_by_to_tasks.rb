class AddFieldAssignedByToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :assigned_by_id, :integer
    add_index :tasks, :assigned_by_id
  end
end
