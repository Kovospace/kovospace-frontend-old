module ModelConcern
	extend ActiveSupport::Concern

	included do
		scope :persisted, -> { where "#{model_name.plural}.id IS NOT NULL" }
		scope :not_persisted, -> { where "#{model_name.plural}.id == NULL" }
	end

	class_methods do
		
	end

	def nested_selected_or_created_any?(assoc, field)
		a = self.send("#{assoc.to_s}_attributes").map { |k,v| v[field] }
		#(!self.category_ids.any?)&&(a.all?(&:empty?))
		(!self.send("#{assoc.to_s.singularize}_ids").any?)&&(a.all?(&:empty?))
	end

end