class ChangeColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :section, false
  end
end
