class HomepageController < ApplicationController

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

    def cookies_info

    end

    def gdpr_info

    end

    private

    def _choose_layout
        case action_name
        when "index"
            return "base"
        when "gdpr_info", "cookies_info"
            return "gdpr_cookies"
        end
    end

end
