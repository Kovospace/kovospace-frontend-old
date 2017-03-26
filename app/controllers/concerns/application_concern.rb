module ApplicationConcern
	extend ActiveSupport::Concern

	### log to console with better visibility
	def logger(input, description="", **options)
		Rails.logger.info "-- #{description} ----------------------------------"
		Rails.logger.info input
		if options[:iterate]
			if input.respond_to?(:length)
				Rails.logger.info "-- count: #{input.try(:length)} --"
				input.each do |inp|
					Rails.logger.info inp
				end
				Rails.logger.info "-- end --"
			end
		end
		Rails.logger.info " "
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
		tmp = instance_variable_get(@singular_varname).send(assoc)
		r = tmp.select { |p| p.id == nil }
		#r = tmp.build if r.blank?
	end

	def load_unperzisted assoc
		tmp = instance_variable_get(@singular_varname).send(assoc)
		logger tmp, "all", iterate: true

		as = tmp - tmp.persisted
		logger as, "not persisted", iterate: true
		as = tmp.build if tmp.blank?
		logger as, "not persisted if build", iterate: true
		instance_variable_set("@#{assoc.to_s}", as)
	end

	def convert_assoc_params assoc
		
		params["#{controller_name.singularize}"]["#{assoc}_attributes"].map { |k, v| v }
	end

	def reload_unsaved_assocs assoc

	end

	def build_if_empty(*assocs)
		assocs.each do |a|
			tmp = instance_variable_get(@singular_varname)
			if (iv = tmp.send(a)).length == 0
				instance_variable_set("@#{a.to_s}", iv.build)
			else
				instance_variable_set("@#{a.to_s}", iv)
			end
		end
	end

	def reload_unsaved(*assocs)
		assocs.each do |a|
			tmp = instance_variable_get(@singular_varname)
			if (iv = tmp.send(a)).length == 0
				instance_variable_set(
					"@#{a.to_s}",
					iv.build
				)
			else
				instance_variable_set("@#{a.to_s}", iv)
			end
		end
	end



	module ClassMethods

	end

end