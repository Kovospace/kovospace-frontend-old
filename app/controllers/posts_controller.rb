class PostsController < ApplicationController

	layout "admin", only: [:new, :create, :edit, :update]

	## override
	def show
		if_urlpart_set_instance :blog, :category
		decide_breadcrumbs
	end

	def all
		@posts = Post.all.page(params[:page]).per(5)
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

	def decide_breadcrumbs
		add_breadcrumb("Blog", blog_path) if @blog
		add_breadcrumb(@blog.title, show_blog_path(@blog)) if @blog
		add_breadcrumb(@post.title.html_safe, show_blog_post_path(@blog, params[:page], @post)) if @post&&@blog&&!@category
		add_breadcrumb(@category.title, show_blog_category_path(@blog, @category, params[:page])) if @category&&@blog
		add_breadcrumb(@post.title.html_safe, show_blog_category_post_path(@blog, @category, params[:page], @post)) if @blog&&@category&&@post
	end

end
