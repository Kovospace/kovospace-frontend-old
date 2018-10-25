class CategoriesController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update]

    private

    def _after_ok_redirect_to
        { controller: "admin", action: "list_blogs" }
    end

    def _permitted_params
         params[:category].permit(
            :title,
            :slug,
            :title_bg,
            :title_bg_cache
         )
    end

end
