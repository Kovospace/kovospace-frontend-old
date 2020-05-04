class CreatePortfolioGalleries < ActiveRecord::Migration
  def change
    create_table :portfolio_galleries do |t|
      t.text :image
      t.text :alt_text
      t.integer :type
      t.references :portfolio, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
