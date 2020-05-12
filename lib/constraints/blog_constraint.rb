class BlogConstraint

    def initialize
        @blogs = Blog.pluck(:slug)
    end

    def matches?(request)
        id = (request.path)[/[a-z0-9-]+$/]
        @blogs.include?(id)
    end

end
