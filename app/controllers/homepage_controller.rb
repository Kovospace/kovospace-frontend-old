class HomepageController < ApplicationController

	def index
        @skills = Skill.all
        @work_states = WorkState.all
        @newslogs = Newslog.last3
        @contact = Contact.new
	end
end
