class Post < ActiveRecord::Base

	has_many(
		:post_tags,
		inverse_of: :post,
		dependent: :destroy 
		# destroy references (joins) to tags in post_tags intertable, not created tags
	)
	has_many(
		:tags,
		through: :post_tags
	)
	accepts_nested_attributes_for(
		:tags,
		allow_destroy: true,
		reject_if: lambda { |c| c[:title].blank? } 
		# skip saving empty tag association if field for new tag is not filled
		# but do not raise validation error
	)

	has_many(
		:category_posts,
		inverse_of: :post,
		dependent: :destroy 
	)
	has_many(
		:categories,
		through: :category_posts
	)
	accepts_nested_attributes_for(
		:categories,
		allow_destroy: true,
		reject_if: lambda { |c| c[:title].blank? } 
	)

end
