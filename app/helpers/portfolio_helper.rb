module PortfolioHelper

    def pbg_types
        ['_desktop', '_tablet', '_mobile']
    end

    def retina_sizes
        ['1x', '2x', '3x']
    end

    def single_sizes
        {
            'xxl' => 1920,
            'xl' => 1366,
            'l' => 1024,
            'm' => 800,
            's' => 640,
            'xs' => 480,
            'xxs' => 375,
            'xxxs' => 320
        }
    end

    def is_sortlink_show_all_active?
        rgx = /(^\/portfolio\/strana\-\d$)|(^\/portfolio$)/
        active = !(rgx =~ request.path).nil?
    end

    def active_class_for_sortlink(skillset)
         active_link_to_class("#{portfolio_url}/#{skillset.slug}")
    end

    def imagePreviewUrl(p, size)
        return p.portfolio_screenshot.screenshot.send(size).url.sub(/_orig\.png$/, '.jpg')
    end

    ### len pre responsive, inak by sa nemala pustat
    def imageHeaderUrlResponsive(size='', uploader='', object=nil)
        if object.nil?
            return @title_bg.send(uploader).send(size).url.sub(/_orig\.png$/, '.jpg')
        else
            tmp = object.send(uploader).send(size).url
            res = tmp.nil? ? "" : tmp.sub(/_orig\.png$/, '.jpg')
            return res
        end
    end

    def kovodown(html)
        #rgx = /\<\#obrazok(\d+)\#\>/
        rgx = /\&lt\;\#obrazok(\d+)\#\&gt\;/
        replacement = '<img>\1</img>'

        ret = html.gsub(rgx) do |match|
            Rails.logger.info "---------------------------"
            #Rails.logger.info match
            image_identificator = match.gsub(rgx, '\1').to_i
            #Rails.logger.info image_identificator
            image = @gallery.detect { |img| img.identificator == image_identificator }
            ### IDE ### Rails.logger.info image.image.gallery_size_xl_1x
            # spravit preload
            #match.gsub(rgx, 'kokot \1 kokot')
            #tiez roi query# Rails.logger.info image[:image]
            Rails.logger.info "---------------------------"
        end

        #markdown html.gsub(rgx, replacement)
        markdown ret
    end

end
