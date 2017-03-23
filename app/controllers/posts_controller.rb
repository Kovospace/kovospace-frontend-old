class PostsController < ApplicationController

	def new
		@tags_all = Tag.all
		@categories_all = Category.all
		@categories = @post.categories.build
		@tags = @post.tags.build
	end

	def create
		@tags_all = Tag.all
		@categories_all = Category.all
		@categories = load_unsaved_assocs :categories
		@tags = load_unsaved_assocs :tags
		super
	end

	def edit
		@tags_all = Tag.all
		@categories_all = Category.all
		@categories = @post.categories.build
		@tags = @post.tags.build
		super
	end

	def update
		@tags_all = Tag.all
		@categories_all = Category.all
		@categories = load_unsaved_assocs :categories
		@tags = load_unsaved_assocs :tags
		super
	end
	
	private 

	def load_form_vars
		
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
