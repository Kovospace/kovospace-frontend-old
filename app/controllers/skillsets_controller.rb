class SkillsetsController < ApplicationController

    before_action :authorize_admin, except: [:index, :show]

    layout "admin", only: [:new, :create, :edit, :update]

    private

    def _after_ok_redirect_to
        { controller: "admin", action: "list_portfolios" }
    end

    def _permitted_params
         params[:skillset].permit(
            :title,
            :description,
            :slug
         )
    end

end
