class HomepageController < ApplicationController

    layout "homepage", only: [:index]
    #layout "user_sitemap", only: [:user_sitemap]
    #layout "gdpr_cookies", only: [:cookies, :gdpr]

	def index
        @skills = Skill.all
        @skillsets = Skillset.all
        @newslogs = Newslog.last3
        @contact = Contact.new
	end

    def user_sitemap
        @portfolios = Portfolio.category_filter(nil)
        @blogs = Blog.all
    end

    def cookies

    end

    def gdpr

    end
end
