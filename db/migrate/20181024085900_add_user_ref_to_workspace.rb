class AddUserRefToWorkspace < ActiveRecord::Migration[5.2]
  def change
    add_reference :workspaces, :user, foreign_key: true
  end
end
