class BlogsController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update]

    def show
        @posts = Blog.where(slug: params[:id])
                    .joins(categories: [:posts])
                    .select('distinct "posts"."id"')

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
