class UsersController < ApplicationController

    skip_filter *_process_action_callbacks.map(&:filter)

    def new
    end

    def edit
    end

    def destroy

    end

    #private

    def permitted_params
         params[:user].permit(
            :email,
            :password,
            :remember_me
         )
    end

end
