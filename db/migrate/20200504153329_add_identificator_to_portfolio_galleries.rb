class AddIdentificatorToPortfolioGalleries < ActiveRecord::Migration
  def change
    add_column :portfolio_galleries, :identificator, :integer
  end
end
