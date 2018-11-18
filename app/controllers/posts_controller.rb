class PostsController < ApplicationController

	before_action :authorize_admin, except: [:all, :show, :create_comment, :reply_to_comment]

	before_action :authenticate_user!, only: [:create_comment, :reply_to_comment]

	before_render :decide_breadcrumbs, only: [:show, :all]

	## override
	def show
		load_on_show
		session[:comment_after_add_back_path] = request.env['PATH_INFO']
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

	def create_comment
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build
		@comment.user = current_user
		saved = @comment.update(permitted_comment_params)
		if saved
			## presmerovat na novy comment id
			redirect_to (session[:comment_after_add_back_path] + "##{@comment.relation_id}")
		else
			if !params[:comment][:reply_to].blank?
				load_on_reply
			end
			load_on_show
			render "show"
		end
	end

	def reply_to_comment
		@post = Post.find(params[:post_id])
		load_on_reply
		load_on_show
		render "show"
	end

	private

	def _choose_layout
        case action_name
        when "all", "show"
            return "base"
        when "new", "create", "edit", "update"
            return "admin"
        end
    end

	## override
	def show_action
		if current_user
			@post = (1..3) === current_user.role ? Post.find(params[:id]) : Post.published.find(params[:id])
		else
			@post = Post.published.find(params[:id])
		end
	end

	def load_on_show
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
		@comments = Naturally.sort(@post.comments, by: :relation_id)
		@comment = @post.comments.build if !@comment
	end

	def load_on_reply
		comm_to_ans_rel_id = @post.comments.find(params[:id]).relation_id
		thread_comments = @post.comments.where("reply_to REGEXP ?", '^'+comm_to_ans_rel_id.to_s+'-\d+$')
		@relation_id = "#{comm_to_ans_rel_id.to_s}-#{(thread_comments.length+1).to_s}"
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
		 	category_ids: []#,
		 	#comments_attributes: [:id, :comment, :reply_to]
		)
	end

	def permitted_comment_params
		params[:comment].permit(
		 	:reply_to,
		 	:comment
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
