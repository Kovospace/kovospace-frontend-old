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

	def build_if_empty(*assocs)
		assocs.each do |a|
			tmp = instance_variable_get(@singular_varname)
			iv = tmp.send(a)
			#logger logger a
			if a.to_s.is_singular?
				if iv.nil?
					tmp.send("build_#{a}")
				end
			else
				if iv.length == 0
					instance_variable_set("@#{a.to_s}", iv.build)
				elsif (iv.length != iv.persisted)
					instance_variable_set("@#{a.to_s}", iv.build)
				else
					instance_variable_set("@#{a.to_s}", iv)
				end
			end
		end
	end

	def sluggable_where(param_name, raw_sql=false)
		p = params[param_name]
		if raw_sql
			col = (/^\d/ =~ p) ? "id" : "slug"
			query = "#{param_name.to_s.sub('_id', '').pluralize}.#{col} = ?"
			return [query, p]
		else
			return (/^\d/ =~ p) ? { id: p.to_i } : { slug: p }
		end
	end

	module ClassMethods

	end

end
