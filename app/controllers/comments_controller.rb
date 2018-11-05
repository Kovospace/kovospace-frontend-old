class CommentsController < ApplicationController

    private

    def _permitted_params
        params[:comment].permit(
            :id
            :comment#,
            #:reply_to
        )
    end

end
