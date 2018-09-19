class CreateNewslogs < ActiveRecord::Migration
  def change
    create_table :newslogs do |t|
      t.text :title
      t.text :txt

      t.timestamps null: false
    end
  end
end
