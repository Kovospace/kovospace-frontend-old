class SkillsController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update]

    private

    def _after_ok_redirect_to
        { controller: "admin", action: "list_homepage" }
    end

    def _permitted_params
         params[:skill].permit(
            :title,
            :description,
            :degree,
            :work_state_id,
            :bg,
            :icon
         )
    end

end
