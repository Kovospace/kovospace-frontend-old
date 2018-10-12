class RemoveBlogIdFromPosts < ActiveRecord::Migration
  def change
    remove_reference :posts, :blog_id, index: true, foreign_key: true
  end
end
