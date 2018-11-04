class AdminController < ApplicationController

    before_action :authorize_admin

    layout "admin"

    def list_homepage
        @result = Skill.all
        @contacts = Contact.all
        @newslog = Newslog.all
    end

    def list_posts
        @result = Post.all
    end

    def list_blogs
        @result = Blog.all
        @categories = Category.all
    end

    def list_portfolios
        @result = Portfolio.all
        @skillsets = Skillset.all
    end

    def list_users
        @result = User.where(admin: false||nil)
    end

end
