class BlogsController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update]

    private

    def _load_vars
        @categories_all = Category.all
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
