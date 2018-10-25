module FriendlyIdConcern
    extend ActiveSupport::Concern

    included do
        friendly_id :title, use: [:slugged, :finders]
        validates :title, presence: true, uniqueness: true
        validates_format_of :slug, :without => /^\d/, multiline: true
        validates :slug, uniqueness: true
    end

    class_methods do

    end

    def slug=(value)
        if value.present?
          write_attribute(:slug, value.parameterize)
        end
    end

end
