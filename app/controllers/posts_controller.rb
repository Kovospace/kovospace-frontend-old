class PostsController < ApplicationController

	layout "admin", only: [:new, :create, :edit, :update]

	private

	def _load_vars
		@tags_all = Tag.all
		@categories_all = Category.all
	end

	def _around_new
		build_if_empty :categories, :tags
	end

	def _around_create_after_save
		build_if_empty :categories, :tags
	end

	def _around_edit
		build_if_empty :categories, :tags
		#also runs around update
	end

	def _after_ok_redirect_to
        { controller: "admin", action: "list_posts" }
    end

    #def _after_save_ok
    	## upravit asociacie priradit blogom jednotlive clanky

    #end

	def _permitted_params
		 params[:post].permit(
		 	:title,
		 	:text,
		 	:slug,
		 	tags_attributes: [:id, :title],
		 	tag_ids: [],
		 	categories_attributes: [:id, :title],
		 	category_ids: []
		 )
	end

end
