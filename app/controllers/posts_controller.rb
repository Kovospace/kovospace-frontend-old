class PostsController < ApplicationController
	
	def new
		@post.tags.build
	end

	private 

	def permitted_params
		 params[:post].permit(
		 	:title,
		 	tags_attributes: [:id, :title]
		 )
	end

end
