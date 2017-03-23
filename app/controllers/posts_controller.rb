class PostsController < ApplicationController
	
	private 

	def load_new_edit_vars
		@tags_all = Tag.all
		@categories_all = Category.all
		@categories = @post.categories.build
		@tags = @post.tags.build
	end

	def load_create_update_vars
		@tags_all = Tag.all
		@categories_all = Category.all
		@categories = load_unsaved_assocs :categories
		@tags = load_unsaved_assocs :tags
	end
		
	def permitted_params
		 params[:post].permit(
		 	:title,
		 	:text,
		 	tags_attributes: [:id, :title],
		 	tag_ids: [],
		 	categories_attributes: [:id, :title],
		 	category_ids: []
		 )
	end

end
