class ErrorsController < ApplicationController

    skip_filter *_process_action_callbacks.map(&:filter)

    layout "errors"

    def show
        status_code = params[:code] || 500
        #flash.alert = "Status #{status_code}"
        render status_code.to_s, status: status_code
    end

end
