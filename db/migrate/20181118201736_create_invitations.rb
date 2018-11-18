class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.integer :invitor_id
      t.integer :workspace_id
      t.string :token

      t.timestamps
    end
  end
end
