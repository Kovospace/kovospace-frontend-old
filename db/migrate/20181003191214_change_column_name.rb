class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :skills, :bg, :theme_color
  end
end
