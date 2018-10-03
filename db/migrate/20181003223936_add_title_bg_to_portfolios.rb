class AddTitleBgToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :title_bg, :text
  end
end
