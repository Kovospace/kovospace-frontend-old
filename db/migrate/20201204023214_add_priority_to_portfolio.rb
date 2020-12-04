class AddPriorityToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :proirity, :integer
  end
end
