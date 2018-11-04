class NewslogsController < ApplicationController

    before_action :authorize_admin, except: [:index, :show]

	layout "admin", only: [:new, :create, :edit, :update]

    private

    def _after_ok_redirect_to
        { controller: "admin", action: "list_homepage" }
    end

    def _permitted_params
         params[:newslog].permit(
            :title,
            :txt
         )
    end

end
