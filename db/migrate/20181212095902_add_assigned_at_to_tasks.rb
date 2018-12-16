class AddAssignedAtToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :assigned_at, :datetime
  end
end
