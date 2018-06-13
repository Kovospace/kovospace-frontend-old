class AddWorkStateToSkills < ActiveRecord::Migration
  def change
    add_reference :skills, :work_state, index: true, foreign_key: true
  end
end
