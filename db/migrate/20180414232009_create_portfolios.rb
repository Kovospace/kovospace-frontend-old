class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :title
      t.text :intro
      t.text :description
      t.text :link

      t.timestamps null: false
    end
  end
end
