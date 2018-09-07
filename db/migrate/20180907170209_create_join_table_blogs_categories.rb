class CreateJoinTableBlogsCategories < ActiveRecord::Migration
  def change
    create_join_table :blogs, :categories do |t|
      # t.index [:portfolio_id, :skill_id]
      # t.index [:skill_id, :portfolio_id]
    end
  end
end
