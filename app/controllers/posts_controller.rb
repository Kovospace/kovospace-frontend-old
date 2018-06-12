class PostsController < ApplicationController

	private

	def load_vars
		@tags_all = Tag.all
		@categories_all = Category.all
	end

	def around_new
		build_if_empty :categories, :tags
	end

	def around_create_after_save
		build_if_empty :categories, :tags
	end

	def around_edit
		build_if_empty :categories, :tags
		#also runs around update
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
