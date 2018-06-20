class AddExplicitOrderToPortfolioScreenshots < ActiveRecord::Migration
  def change
    add_column :portfolio_screenshots, :explicit_order, :integer
  end
end
