class BlogsController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update]

    add_breadcrumb "Blog", :blogs_path

    def show
        # na uvodke blogu len top clanky, bez strankovania
        add_breadcrumb @blog.title, show_blog_path(@blog)

        if params[:category_id].blank?
            @categories = @blog.categories.blog_order(@blog.id)
            posts_ids = Blog.where(sluggable_where :id)
                        .joins(categories: [:posts])
                        .where('posts.published = ?', true)
                        .select('distinct "posts"."id"')
                        .map(&:id)
            @posts = Post.where(id: posts_ids)
                        .page(params[:page])
                        .per(2)
            @posts_best = @posts
            @posts_new = @posts
        else
            posts_ids = Blog.where(sluggable_where :id)
                        .joins(categories: [:posts])
                        .where('posts.published = ?', true)
                        .where(sluggable_where :category_id, true)
                        .select('distinct "posts"."id"')
                        .map(&:id)
            @category = Category.find(params[:category_id])
            @posts = Post.where(id: posts_ids)
                        .order_as_story(@category.id)
                        .page(params[:page])
                        .per(2)

            add_breadcrumb @category.title, show_blog_category_path(@blog, @category, params[:page])
        end

    end

    private

    def _load_vars
        @categories_all = Category.all
        @tags_all = Tag.all
        #@posts_all = Blog
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
        { controller: "admin", action: "list_blogs" }
    end

    def _permitted_params
         params[:blog].permit(
            :title,
            :description,
            :title_bg,
            :title_bg_cache,
            :slug,
            category_orders: [:id],
            tag_ids: [],
            category_ids: [],
            categories_attributes: [:title],
            tags_attributes: [:title]
         )
    end

end
