class CreatePortfolioScreenshots < ActiveRecord::Migration
  def change
    create_table :portfolio_screenshots do |t|
      t.references :portfolio, index: true, foreign_key: true
      t.string :screenshot

      t.timestamps null: false
    end
  end
end
