class PostTag < ActiveRecord::Base

	include LogConcern

	belongs_to(
		:post,
		inverse_of: :post_tags
	)
	belongs_to(
		:tag,
		inverse_of: :post_tags#,
		#dependent: :destroy
		# deletes also tag when deleting post that contains this tag
		# no matter if others posts also use this tag
	)

	#after_destroy :remove_unused_tags

	def remove_unused_tags
		# runs multiple times, depending of how much joins is with Tag model
		# removes tags that are not related to any other article(s)
		if (tag = Tag.find(self.tag_id)).posts.blank?
			tag.delete
		end
	end

end
