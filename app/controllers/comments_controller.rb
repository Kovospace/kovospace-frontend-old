class CommentsController < ApplicationController

    before_action :under_construction

    private

    def _permitted_params
        params[:comment].permit(
            :id
            :comment#,
            #:reply_to
        )
    end

end
