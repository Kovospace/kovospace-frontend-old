module FriendlyIdConcern
    extend ActiveSupport::Concern

    included do
        friendly_id_config.reserved_words.concat(["vsetky-clanky"])
        friendly_id :title, use: [:slugged, :finders]
        validates :title, presence: true, uniqueness: true
        validates_format_of :slug, :without => /^\d/, multiline: true
        validate :slug_no_pagination_conflict
        validates :slug, uniqueness: true
    end

    class_methods do

    end

    def slug=(value)
        if value.present?
          write_attribute(:slug, value.parameterize)
        end
    end

    def slug_no_pagination_conflict
        if !(slug =~ /^strana-\d$/).nil?
            self.errors.add(:slug, :used_in_pagination)
        end
    end

end
