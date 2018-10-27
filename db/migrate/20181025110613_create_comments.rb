class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string  :body
      t.references :commentable_id
      t.references :commentable_type
      t.references :user_id
      t.timestamps
    end
  end
end
