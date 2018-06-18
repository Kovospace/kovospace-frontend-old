class AddIconToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :icon, :string
  end
end
