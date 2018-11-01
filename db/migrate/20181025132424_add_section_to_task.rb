class AddSectionToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :section, :boolean, default: false
  end
end
