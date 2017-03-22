class CreateCategoryPosts < ActiveRecord::Migration
  def change
    create_table :category_posts do |t|
    	t.belongs_to :category
    	t.belongs_to :post

      t.timestamps null: false
    end
  end
end
