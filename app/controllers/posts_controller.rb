class PostsController < ApplicationController

	layout "admin", only: [:new, :create, :edit, :update]

	## override
	def show
		if_urlpart_set_instance :blog, :category
	end

	def all
		@posts = Post.all.page(params[:page]).per(10)
		render "index"
	end

	private

	def _load_vars
		@tags_all = Tag.all
		@categories_all = Category.all
	end

	def _around_new
		build_if_empty :categories, :tags
	end

	def _after_save_fail
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
		 	:avatar,
		 	:avatar_cache,
		 	:intro,
		 	tags_attributes: [:id, :title],
		 	tag_ids: [],
		 	categories_attributes: [:id, :title],
		 	category_ids: []
		 )
	end

	def if_urlpart_set_instance(*mdls)
		mdls.each do |mdl_name|
			if !(p = params["#{mdl_name.to_s}_id"]).blank?
				content = mdl_name.to_s.classify.constantize.find(p)
				instance_variable_set("@#{mdl_name.to_s}", content)
			end
		end
	end

end
