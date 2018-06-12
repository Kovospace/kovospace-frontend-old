class AdminController < ApplicationController

    layout "admin"

    def index

    end

    def list_skills
        @result = Skill.all
    end

    def list_posts
        @result = Post.all
    end

end
