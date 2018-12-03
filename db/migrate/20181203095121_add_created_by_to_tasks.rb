class AddCreatedByToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :created_by_id, :integer
    add_index :tasks, :created_by_id
  end
end
