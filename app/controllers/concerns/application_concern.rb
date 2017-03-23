module ApplicationConcern
	extend ActiveSupport::Concern

	### log to console with better visibility
	def logger(input)
		Rails.logger.info "------------------------------------"
		Rails.logger.info input
	end

	### retruns model instance based on controller name if exists
	### else nil
	def model_exist?
		Module.const_get(controller_name.classify)
	rescue NameError
		return nil
	end

	### loads unsaved associations
	### fix for associated field values not remembered after validation fail
	### using @model.something.build in create action for example results in one empty field
	### not using it results that fields are also generated from checked checkboxes
	def load_unsaved_assocs assoc
		instance_variable_get(@singular_varname)
		.send(assoc)
		.select { |p| p.id == nil }
	end

	module ClassMethods

	end

end