class AddSlugToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :slug, :string
  end
end
