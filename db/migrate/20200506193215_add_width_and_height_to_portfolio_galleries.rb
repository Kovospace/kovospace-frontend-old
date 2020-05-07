class AddWidthAndHeightToPortfolioGalleries < ActiveRecord::Migration
  def change
    add_column :portfolio_galleries, :width, :integer
    add_column :portfolio_galleries, :height, :integer
  end
end
