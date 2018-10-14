class AddPortfoliosCountToSkillset < ActiveRecord::Migration
  def change
    add_column :skillsets, :portfolios_count, :integer
  end
end
