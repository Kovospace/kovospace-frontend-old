class CategoryPost < ActiveRecord::Base

	include LogConcern

	belongs_to :post, inverse_of: :category_posts
	belongs_to :category, inverse_of: :category_posts

	#after_destroy :remove_unused_categories

	#def remove_unused_categories
		
	#end
	
end
