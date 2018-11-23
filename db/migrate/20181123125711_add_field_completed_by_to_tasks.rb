class AddFieldCompletedByToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :completed_by, :integer
    add_index :tasks, :completed_by
  end
end
