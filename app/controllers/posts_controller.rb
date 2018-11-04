class PostsController < ApplicationController

	layout "admin", only: [:new, :create, :edit, :update]
	before_render :decide_breadcrumbs, only: [:show, :all]

	## override
	def show
		if_urlpart_set_instance :blog, :category
		if @category
			#@curr_id = @post.id
			@serial_posts_ids = CategoryPost
				.where(category_id: @category.id)
				.order(:sequence)
				.pluck(:post_id)
			@post_order_index = @serial_posts_ids.index(@post.id)
			if @post_order_index == @serial_posts_ids.length-1
				@prev_post = Post.find(@serial_posts_ids[@serial_posts_ids.length-2])
			elsif @post_order_index == 0
				@next_post = Post.find(@serial_posts_ids[1])
			else
				@prev_post = Post.find(@serial_posts_ids[@post_order_index-1])
				@next_post = Post.find(@serial_posts_ids[@post_order_index+1])
			end
		end
		@comments = @post.comments
		@comment = @post.comments.new if !@comment
	end

	def all
		@posts = Post.published.page(params[:page]).per(5)
		render "index"
	end

	def publish
		Post.find(params[:id]).update_attribute(:published, true)
		redirect_to :list_posts
	end

	def suspend
		Post.find(params[:id]).update_attribute(:published, false)
		redirect_to :list_posts
	end

	private

	## override
	def show_action
		@post = current_user.blank? ? Post.published.find(params[:id]) : Post.find(params[:id])
	end

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
		add_breadcrumb("Blog", blog_path)
		add_breadcrumb(@blog.title, show_blog_path(@blog)) if @blog
		if (request.url =~ /\/vsetky-clanky(\/strana-\d)?$/)&&!@post&&!@blog&&!@category
			add_breadcrumb("Všetky články", all_posts_path(params[:page]))
		elsif (request.url =~ /\/vsetky-clanky\//)&&@post&&!@blog&&!@category
			add_breadcrumb("Všetky články", all_posts_path(params[:page]))
			add_breadcrumb(@post.title.html_safe, show_post_path(params[:page], @post))
		elsif @post&&!@blog&&!@category
			add_breadcrumb(@post.title.html_safe, show_post2_path(@post))
		end
		add_breadcrumb(@post.title.html_safe, show_blog_post_path(@blog, params[:page], @post)) if @post&&@blog&&!@category
		add_breadcrumb(@category.title, show_blog_category_path(@blog, @category, params[:page])) if @category&&@blog
		add_breadcrumb(@post.title.html_safe, show_blog_category_post_path(@blog, @category, params[:page], @post)) if @blog&&@category&&@post
	end

end
