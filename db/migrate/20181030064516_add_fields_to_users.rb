class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string
    add_column :users, :department, :string
    add_column :users, :about_me, :text
  end
end
