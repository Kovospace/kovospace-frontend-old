class PostsController < ApplicationController
	
	private 

	def load_form_vars
		@new_tag = @post.tags.build
		@new_category = @post.categories.build
		@categories = Category.all
		@tags = Tag.all
	end

	def permitted_params
		 params[:post].permit(
		 	:title,
		 	tags_attributes: [:id, :title],
		 	tag_ids: []
		 )
	end

end
