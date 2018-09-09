class BlogCategory < ActiveRecord::Base

    include LogConcern

    belongs_to :blog, inverse_of: :blog_categories
    belongs_to :category, inverse_of: :blog_categories

end
