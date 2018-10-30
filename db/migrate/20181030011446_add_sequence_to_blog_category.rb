class AddSequenceToBlogCategory < ActiveRecord::Migration
  def change
    add_column :blog_categories, :sequence, :integer
  end
end
