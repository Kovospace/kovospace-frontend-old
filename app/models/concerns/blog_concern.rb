module BlogConcern
    extend ActiveSupport::Concern

    included do
        validate :blogwise_slug_unique
    end

    class_methods do

    end

    def blogwise_slug_unique
        curr_model = self.model_name.name.downcase.to_sym
        [:blog, :post, :category].each do |mdl|
            if !(mdl == curr_model)
                if !mdl.to_s.classify.constantize.where(slug: slug).blank?
                    self.errors.add(:title, :used_in_blog_region)
                    break
                end
            end
        end
    end


end
