class CreateBlogTags < ActiveRecord::Migration
  def change
    create_table :blog_tags do |t|
      t.references :blog, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
    end
  end
end
