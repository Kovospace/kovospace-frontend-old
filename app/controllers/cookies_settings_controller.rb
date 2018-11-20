class CookiesSettingsController < ApplicationController

    skip_filter *_process_action_callbacks.map(&:filter)

    def create
        redirect_to :back
    end

    private

end
