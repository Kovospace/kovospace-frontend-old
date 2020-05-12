
class PortfolioConstraint

    def initialize
        #@skillsets = Skillset.pluck(:slug)
    end

    def matches?(request)
        slug = request.path.gsub("/portfolio/", "")
        @skillsets.include?(slug)
    end

end

