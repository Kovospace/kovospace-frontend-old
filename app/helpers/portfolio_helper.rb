module PortfolioHelper

    def pbg_types
        ['', '_tablet', '_mobile']
    end

    def showsection_decide_titlebg_type(obj)
        b = obj.portfolio_titlebgs
        i = b.first
        if b.blank?
            return :nothing
        elsif i.blank?
            return :nothing
        elsif !i.title_bg.blank?&&!i.title_bg_tablet.blank?&&!i.title_bg_mobile.blank?
            return :responsive
        elsif !i.title_bg.blank?&&i.title_bg_tablet.blank?&&i.title_bg_mobile.blank?
            return :desktop
        elsif i.title_bg.blank?&&i.title_bg_tablet.blank?&&!i.title_bg_mobile.blank?
            return :mobile
        elsif !i.title_bg.blank?
            return :desktop
        else
            return :nothing
        end
    end

    def is_sortlink_show_all_active?
        rgx = /(^\/portfolio\/strana\/\d$)|(^\/portfolio$)/
        active = !(rgx =~ request.path).nil?
    end

    def active_class_for_sortlink(skillset)
         active_link_to_class("#{portfolio_url}/#{skillset.slug}")
    end

    def imagePreviewUrl(p, size)
        return p.portfolio_screenshot.screenshot.send(size).url.sub(/_orig\.png$/, '.jpg')
    end

    def imageHeaderUrl(size)
        return @portfolio.portfolio_titlebgs.first.title_bg.send(size).url.sub(/_orig\.png$/, '.jpg')
    end

end
