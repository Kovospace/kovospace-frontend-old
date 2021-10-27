class NewslogsController < ApplicationController

    before_action :authorize_admin, except: [:index, :show]

	#layout "admin", only: [:new, :create, :edit, :update]
    #layout "base", only: [:index, :show]

    def index
        @newslogs_groupped = @newslogs.all
            .order(created_at: :desc)
            .group_by { |m| m.created_at.beginning_of_year }
    end

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
         params[:newslog].permit(
            :title,
            :txt
         )
    end

end
