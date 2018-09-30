class RemoveScreenshotsFromPortfolio < ActiveRecord::Migration
  def change
    remove_column :portfolios, :screenshots, :text
  end
end
