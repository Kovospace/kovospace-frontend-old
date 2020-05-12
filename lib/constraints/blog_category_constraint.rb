class BlogCategoryConstraint

    def initialize
        #@categories = Category.pluck(:slug)
    end

    def matches?(request)
        id = (request.path)[/[a-z0-9-]+$/]
        return true if id =~ /strana-\d/
        @categories.include?(id)
    end

end
