class PostsController < ApplicationController
	
	private 

	def load_new_edit_vars
		@tags_all = Tag.all
		@categories_all = Category.all
		@categories = @post.categories.build
		#@tags = @post.tags.build
		#@post.categories.build
	end

	def load_create_update_vars
		@tags_all = Tag.all
		@categories_all = Category.all
		logger @post.categories_attributes
		#build_if_empty :categories
		reload_unsaved :categories


		#@post.categories.build
		#@categories = @post.categories.build
		#@post.tags.build
		#@tags = @post.tags.build#.assign_attributes(convert_assoc_params(:categories))
		#c = convert_assoc_params(:categories)
		#logger c.length
		#c.each do |param|
			#logger param
			#@categories = @post.tags.build.assign_attributes(param.permit(:title))
			#@categories = Category.new.assign_attributes(param.permit(:title))
		#end
		#logger convert_assoc_params(:categories)
		#load_unperzisted :categories
		#load_unperzisted :tags
		
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
