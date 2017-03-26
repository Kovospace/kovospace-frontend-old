module ModelConcern
	extend ActiveSupport::Concern

	included do

		scope :persisted, -> { where "#{model_name.plural}.id IS NOT NULL" }

		scope :not_persisted, -> { where "#{model_name.plural}.id == NULL" }

	end

	module ClassMethods
		
	end

end