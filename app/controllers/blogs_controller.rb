class BlogsController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update]

    def show
        # na uvodke blogu len top clanky, bez strankovania
        #
        if params[:category_id].blank?
            posts_ids = Blog.where(sluggable_where :id)
                        .joins(categories: [:posts])
                        .select('distinct "posts"."id"')
                        .map(&:id)
        else
            posts_ids = Blog.where(sluggable_where :id)
                        .joins(categories: [:posts])
                        .where(sluggable_where :category_id, true)
                        .select('distinct "posts"."id"')
                        .map(&:id)
            @category = Category.find(params[:category_id])
        end
        @posts = Post.find(posts_ids)
        if params[:category_id].blank?
            @posts_best = @posts
            @posts_new = @posts
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
            category_ids: []
         )
    end

end
