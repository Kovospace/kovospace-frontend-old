class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :title
      t.text :description
      t.integer :degree

      t.timestamps null: false
    end
  end
end
