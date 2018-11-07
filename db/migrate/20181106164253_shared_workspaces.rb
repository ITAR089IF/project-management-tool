class SharedWorkspaces < ActiveRecord::Migration[5.2]
  create_table :shared_workspaces do |t|
    t.references :invited_workspace, foreign_key: true
    t.references :member, foreign_key: true

    t.timestamps
  end
    add_foreign_key :shared_workspaces, :workspace, column: :invited_workspace_id, primary_key: :id
    add_foreign_key :shared_workspaces, :users, column: :member_id, primary_key: :id
  end
end
