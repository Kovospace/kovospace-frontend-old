class AddThemeColorToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :theme_color, :text
  end
end
