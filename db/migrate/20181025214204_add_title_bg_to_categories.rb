class AddTitleBgToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :title_bg, :text
  end
end
