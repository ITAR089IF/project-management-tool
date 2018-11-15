class AddJobRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :job_role, :string
    change_column :users, :role, :string, default: "user"
  end
end
