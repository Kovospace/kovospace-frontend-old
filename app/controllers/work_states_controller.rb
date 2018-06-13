class WorkStatesController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update]

    private

    def _after_ok_redirect_to
        { controller: "admin", action: "list_skills" }
    end

    def _permitted_params
         params[:work_state].permit(
            :title,
            :description
         )
    end

end
