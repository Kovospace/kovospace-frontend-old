class ContactsController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update, :show]

    def index
        redirect_to controller: "homepage", action: 'index'
    end

    def seen
        update_seen true
        redirect_to _after_ok_redirect_to
    end

    def unseen
        update_seen false
        redirect_to _after_ok_redirect_to
    end

    private

    def update_seen boo
        Contact.find(params[:id]).update({ seen: boo })
    end

    def _after_ok_redirect_to
        if action_name == "create"
            { controller: "homepage", action: "index" }
        else
            { controller: "admin", action: "list_homepage" }
        end
    end

    def _permitted_params
         params[:contact].permit(
            :sender,
            :title,
            :msg,
            :name,
            :seen
         )
    end

end
