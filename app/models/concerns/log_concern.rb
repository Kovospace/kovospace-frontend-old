module LogConcern
	extend ActiveSupport::Concern

	def logger(input)
		Rails.logger.info "-- #{model_name} ----------------------------------"
		Rails.logger.info input
	end

	included do
		
	end

	module ClassMethods
		
		def logger(input)
			Rails.logger.info "-- #{model_name} ----------------------------------"
			Rails.logger.info input
		end
	
	end

end