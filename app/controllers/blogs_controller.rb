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
    end

    private

    def _load_vars
        @categories_all = Category.all
        #@posts_all = Blog
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
