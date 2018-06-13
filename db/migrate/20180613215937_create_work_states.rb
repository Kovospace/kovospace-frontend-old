class CreateWorkStates < ActiveRecord::Migration
  def change
    create_table :work_states do |t|
      t.text :title
      t.text :description

      t.timestamps null: false
    end
  end
end
