class AddIndexesForSearchFields < ActiveRecord::Migration[5.2]
  def change
    add_index :workspaces,  :name
    add_index :projects,    :name
    add_index :tasks,       :title
  end
end
