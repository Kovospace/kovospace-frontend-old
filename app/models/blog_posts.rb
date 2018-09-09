class BlogPost < ActiveRecord::Base

    include LogConcern

    belongs_to :blog, inverse_of: :blog_posts
    belongs_to :category, inverse_of: :blog_posts

end
