class CookiesSettingsController < ApplicationController

    require "json"

    skip_filter *_process_action_callbacks.map(&:filter)

    before_action :cookies_accept
    before_action :create_cookie

    def create
        redirect_to :back
    end

    def update
        redirect_to :home
    end

    private

    def create_cookie
        cookies[:remember_cookies_accept] = {
            value: JSON.generate([
                params[:cookie]
            ]),
            expires: 1.year.from_now#,
            #domain: 'kovo.space'
        }
    end

end
