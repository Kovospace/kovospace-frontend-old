class WorkExperience < ActiveRecord::Base
	default_scope { order(start: :desc) }
end
