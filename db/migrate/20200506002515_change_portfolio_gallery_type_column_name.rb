class ChangePortfolioGalleryTypeColumnName < ActiveRecord::Migration
  def change
     rename_column :portfolio_galleries, :type, :typ
  end
end
