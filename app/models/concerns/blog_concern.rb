module BlogConcern
    extend ActiveSupport::Concern

    included do
        validate :blogwise_slug_unique
    end

    class_methods do

    end

    def blogwise_slug_unique
        [:blog, :post, :category].each do |mdl|
            if !mdl.to_s.classify.constantize.where(slug: slug).blank?
                self.errors.add(:title, :used_in_blog_region)
                break
            end
        end
    end


end
