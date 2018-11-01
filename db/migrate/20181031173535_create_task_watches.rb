class CreateTaskWatches < ActiveRecord::Migration[5.2]
  def change
    create_table :task_watches do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
