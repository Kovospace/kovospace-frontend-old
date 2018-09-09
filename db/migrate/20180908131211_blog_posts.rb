class BlogPosts < ActiveRecord::Migration
  def change


    create_table :blog_posts do |t|
        t.belongs_to :post
        t.belongs_to :blog

        #t.timestamps null: true
    end
  end
end
