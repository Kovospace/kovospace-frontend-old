class HomepageController < ApplicationController

	def index
        @skills = Skill.all
        @work_states = WorkState.all
        @contact = Contact.new
	end
end
