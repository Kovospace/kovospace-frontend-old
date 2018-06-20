class AddScreenshotsToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :screenshots, :string
  end
end
