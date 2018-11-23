class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text  :body
      t.boolean :is_read, default: false
      t.references :messageable, polymorphic: true
      t.references :user
      t.timestamps
    end
    add_index :messages, [ :user_id, :is_read ]
  end
end
