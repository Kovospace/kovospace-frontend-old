class AddTitleBgTabletAndTitleBgMobileToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :title_bg_tablet, :text
    add_column :portfolios, :title_bg_mobile, :text
  end
end
