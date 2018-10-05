class RemoveImagesFromPortfolio < ActiveRecord::Migration
  def change
    remove_column :portfolios, :title_bg, :text
    remove_column :portfolios, :title_bg_tablet, :text
    remove_column :portfolios, :title_bg_mobile, :text
  end
end
