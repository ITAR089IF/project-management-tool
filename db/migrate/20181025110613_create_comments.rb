class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string  :body
      t.references :commentable
      t.string :commentable_type
      t.references :user
      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :users, :id
  end
end
