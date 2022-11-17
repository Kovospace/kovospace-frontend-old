class CreateWorkExperiences < ActiveRecord::Migration
  def change
    create_table :work_experiences do |t|
      t.string :title
      t.string :web
      t.string :position
      t.string :place
      t.date :start
      t.date :end

      t.timestamps null: false
    end
  end
end
