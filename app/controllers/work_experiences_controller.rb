class WorkExperiencesController < ApplicationController

    before_action :authorize_admin, except: [:index, :show]

	#layout "admin", only: [:new, :create, :edit, :update]
    #layout "base", only: [:index, :show]

    private

    def _choose_layout
        case action_name
        when "index", "show"
            return "base"
        when "new", "create", "edit", "update"
            return "admin"
        end
    end

    def _after_ok_redirect_to
        { controller: "admin", action: "list_homepage" }
    end

    def _permitted_params
         params[:work_experience].permit(
            :title,
            :web,
            :position,
            :place,
            :start,
            :end
         )
    end

end
