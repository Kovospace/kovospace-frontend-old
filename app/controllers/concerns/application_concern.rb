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

		record = instance_variable_get(@singular_varname)

		if action_name == "new" || action_name == "create"

			assocs.each do |a, opts|
				assoc_var_name = "@#{a.to_s.singularize}"
				build_command = a.to_s.is_singular? ? "build_#{a.to_s}" : "build"

				if (a.to_s.is_singular?)
					if record.send(a).nil?
						# association does not exist
						if record.has_attribute? "#{a.to_s}_id"
							# but parent model have foreign key field for assoc
							instance_variable_set(assoc_var_name, record.send(build_command))
							#set single record instance variable and also build parent object assocition
						end
					else
						instance_variable_set(assoc_var_name, record.send(a))
					end
				else
					# if associated has not been build yet
					if (iv = record.send(a)).length == 0
						instance_variable_set(assoc_var_name, iv.send(build_command))
					else
						# if has been built
						# if empty field leave after reload for example after failed association
						# due to reject_if option of accept_nested_attributes_for
						# create and append one to associations (record with empty id)
						if !iv.collect(&:id).any? { |a| a.nil? }
							iv << a.to_s.singularize.classify.constantize.send(:new)
						end
						instance_variable_set(assoc_var_name, iv)
					end
				end
			end

		elsif action_name == "edit" || action_name == "update"

			assocs.each do |a, opts|
				assoc_var_name = "@#{a.to_s.singularize}"
				if a.to_s.is_singular?
					instance_variable_set(assoc_var_name, record.send(a))
				else
					any_builded_assoc = record.send(a).map { |r| r.id.blank? } .any?
					if !any_builded_assoc
						record.send(a).send(:build)
					end
					#instance_variable_set(assoc_var_name, record.send(a))
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

	def authorize_admin
		redirect_to(user_session_path(reason: "noadmin")) if current_user.role != 1
	end

	module ClassMethods

	end

end
