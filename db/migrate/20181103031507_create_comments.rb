class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.text :reply_to
      t.timestamps null: false
    end
  end
end
