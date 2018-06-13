class HomepageController < ApplicationController

	def index
        @skills = Skill.all
        @work_states = WorkState.all
	end
end
