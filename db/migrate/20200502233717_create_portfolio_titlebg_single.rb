class CreatePortfolioTitlebgSingle < ActiveRecord::Migration
  def change
    create_table :portfolio_titlebg_singles do |t|
      t.text :title_bg
      t.text :alt_text
    end
  end
end
