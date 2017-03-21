module ApplicationConcern
	extend ActiveSupport::Concern

	def logger(input)
		Rails.logger.info "------------------------------------"
		Rails.logger.info input
	end

	def model_exist?
		model = Module.const_get(controller_name.classify)
	rescue NameError
		return nil
	end

	module ClassMethods

	end

end