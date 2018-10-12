class BlogPost < ActiveRecord::Base

    include LogConcern

    belongs_to :blog, inverse_of: :blog_posts
    belongs_to :post, inverse_of: :blog_posts

end
