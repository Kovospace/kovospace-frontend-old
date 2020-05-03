class AddPortfolioIdToPortfolioTitlebgSingles < ActiveRecord::Migration
  def change
    add_reference :portfolio_titlebg_singles, :portfolio, index: true, foreign_key: true
  end
end
