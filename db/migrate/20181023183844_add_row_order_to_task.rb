class AddRowOrderToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :row_order, :integer
    add_index :tasks, :row_order
  end
end
