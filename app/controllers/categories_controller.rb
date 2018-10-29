class CategoriesController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update]

    private

    def _around_edit
        #build_if_empty :posts
        #also runs around update
    end

    def _load_vars
       #@posts = @category.posts
    end

    def _after_ok_redirect_to
        { controller: "admin", action: "list_blogs" }
    end

    def _permitted_params
         params[:category].permit(
            :title,
            :slug,
            :title_bg,
            :title_bg_cache,
            posts_attributes: [:id]
         )
    end

end
