class AddSequenceToCategoryPosts < ActiveRecord::Migration
  def change
    add_column :category_posts, :sequence, :integer
  end
end
