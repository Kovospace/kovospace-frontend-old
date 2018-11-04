class CommentsController < ApplicationController

    private

    def _permitted_params
        params[:comment].permit(
            :text
        )
    end

end
