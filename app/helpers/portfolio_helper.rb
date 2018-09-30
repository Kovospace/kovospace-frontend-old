module PortfolioHelper

    def colors(obj)
        return "style=background-color:##{obj.bg_color};color:##{obj.text_color};"
    end
end
