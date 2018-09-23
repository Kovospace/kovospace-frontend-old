class AddSkillsetToPortfolios < ActiveRecord::Migration
  def change
    add_reference :portfolios, :skillset, index: true, foreign_key: true
  end
end
