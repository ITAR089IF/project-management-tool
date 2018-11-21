class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :invitor, index: true
      t.references :workspace, index: true
      t.string :token

      t.timestamps
    end
  end
end
