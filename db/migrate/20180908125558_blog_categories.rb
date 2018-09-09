class BlogCategories < ActiveRecord::Migration
  def change

    create_table :blog_categories do |t|
        t.belongs_to :category
        t.belongs_to :blog

        #t.timestamps null: true
    end

  end
end
