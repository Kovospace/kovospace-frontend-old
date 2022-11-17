class HomepageController < ApplicationController

    before_action :vars, only: [:index, :new_contact, :create_contact]

	def index

	end

    def user_sitemap
        @portfolios = Portfolio.category_filter(nil)
        @blogs = Blog.all
    end

    def cookies_info

    end

    def gdpr_info

    end

    #def new_contact

    #end

    def create_contact
        @contact = Contact.new(contact_params)
        if @contact.save
            redirect_to "/"
        else
            render "index"
        end
    end

    private

    def _choose_layout
        case action_name
        when "index", "create_contact"
            return "base"
        when "gdpr_info", "cookies_info"
            return "gdpr_cookies"
        end
    end

    def vars
        @skills = Skill.all
        @skillsets = Skillset.all
        @newslogs = Newslog.last3
        @work_experiences = WorkExperience.all
        @work_experience_current = @work_experiences.first
        @work_experience_past = @work_experiences.select { |we| !we.end.nil? }
        @contact = Contact.new
    end

    def contact_params
        params[:contact].permit(
            :sender,
            :title,
            :msg,
            :i_am_not_sputnik,
            :accept_gdpr
        )
    end

end
