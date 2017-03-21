class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
    	t.belongs_to :post
    	t.belongs_to :tag

      t.timestamps null: false
    end
  end
end
