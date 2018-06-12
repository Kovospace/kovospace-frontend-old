class UsersController < ApplicationController

    skip_filter *_process_action_callbacks.map(&:filter)

    #private

    def permitted_params
         params[:user].permit(
            :email,
            :password,
            :remember_me
         )
    end

end
