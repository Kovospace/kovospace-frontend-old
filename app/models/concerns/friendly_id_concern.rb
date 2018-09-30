module FriendlyIdConcern
    extend ActiveSupport::Concern

    included do

    end

    class_methods do

    end

    def slug=(value)
        if value.present?
          write_attribute(:slug, value.parameterize)
        end
    end

end
