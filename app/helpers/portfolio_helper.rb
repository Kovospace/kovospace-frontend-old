module PortfolioHelper

    def colors_for_actions(col)
        if !col.blank?
            fg_col = (Color::RGB.by_css(col).brightness > 0.5) ? "#111" : "#fafafa"
            bg_col = Color::RGB.by_css(col).hex
            return "style=background-color:##{bg_col};color:#{fg_col};"
        end
        return ""
    end
end
