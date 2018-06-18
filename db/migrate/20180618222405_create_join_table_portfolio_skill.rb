class CreateJoinTablePortfolioSkill < ActiveRecord::Migration
  def change
    create_join_table :portfolios, :skills do |t|
      # t.index [:portfolio_id, :skill_id]
      # t.index [:skill_id, :portfolio_id]
    end
  end
end
