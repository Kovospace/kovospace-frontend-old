class AddAltTextToPortfolioScreenshots < ActiveRecord::Migration
  def change
    add_column :portfolio_screenshots, :alt_text, :string
  end
end
