class FixTitleBgUploaderColumnName < ActiveRecord::Migration
  def change
    rename_column :portfolio_titlebgs, :title_bg, :title_bg_desktop
  end
end
