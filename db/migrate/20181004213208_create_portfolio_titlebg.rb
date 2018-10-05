class CreatePortfolioTitlebg < ActiveRecord::Migration
  def change
    create_table :portfolio_titlebgs do |t|
      t.text :title_bg
      t.text :title_bg_tablet
      t.text :title_bg_mobile
      t.references :portfolio, index: true, foreign_key: true
    end
  end
end
