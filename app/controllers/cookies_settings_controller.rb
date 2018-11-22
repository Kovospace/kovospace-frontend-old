class CookiesSettingsController < ApplicationController

    require "json"

    skip_filter *_process_action_callbacks.map(&:filter)

    def create
        cookies[:remember_cookies_accept] = {
            value: JSON.generate([
                params[:cookie]
            ]),
            expires: 1.year.from_now#,
            #domain: 'kovo.space'
        }
        redirect_to :back
    end

    private

end
