class BlogTag < ActiveRecord::Base

    include LogConcern

    belongs_to :blog, inverse_of: :blog_tags
    belongs_to :tag, inverse_of: :blog_tags

end
