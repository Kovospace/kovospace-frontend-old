class AdminController < ApplicationController

    layout "admin"

    def index

    end

    def list_homepage
        @result = Skill.all
        @work_progress = WorkState.all
        @contacts = Contact.all
    end

    def list_posts
        @result = Post.all
    end

end
