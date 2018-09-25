class AddRealisDateToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :realis_date, :date
  end
end
