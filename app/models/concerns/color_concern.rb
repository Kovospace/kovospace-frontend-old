module ColorConcern
    extend ActiveSupport::Concern

    included do

    end

    class_methods do

    end

    def bg_color
        if !theme_color.blank?
            return Color::RGB.by_css(theme_color).hex
        end
    end

    def text_color
        if !theme_color.blank?
            return (Color::RGB.by_css(theme_color).brightness > 0.5) ? "111" : "fafafa"
        end
    end

    def fakehover_class
        if !theme_color.blank?
            return (Color::RGB.by_css(theme_color).brightness > 0.5) ? "fakehover dark" : "fakehover"
        end
    end

    def bg_style
        return "style=\"background-color:##{bg_color};\"".html_safe
    end

    def fg_style
        return "style=\"color:##{text_color};\"".html_safe
    end

    def style_css
        return "color:##{text_color};background-color:##{bg_color} !important;".html_safe
    end

    def style
        return "style=\"#{style_css}\"".html_safe
    end

    def style_inverted
        return "style=\"color:##{bg_color};background-color:##{text_color};\"".html_safe
    end

    def fakehover
        return "class=\"#{fakehover_class}\"".html_safe
    end

end
