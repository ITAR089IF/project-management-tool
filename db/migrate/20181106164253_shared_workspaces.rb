class SharedWorkspaces < ActiveRecord::Migration[5.2]
  create_table :shared_workspaces do |t|
    t.references :workspace, foreign_key: true
    t.references :user, foreign_key: true

    t.timestamps
  end
end
