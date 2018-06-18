class AddBgToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :bg, :string
  end
end
