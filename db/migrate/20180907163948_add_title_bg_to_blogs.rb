class AddTitleBgToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :title_bg, :text
  end
end
