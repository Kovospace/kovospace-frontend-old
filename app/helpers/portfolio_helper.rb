module PortfolioHelper

    ### responsive [show, new, edit]
    def pbg_types
        ['_desktop', '_tablet', '_mobile']
    end

    ### vseobecne
    def retina_sizes
        ['1x', '2x', '3x']
    end

    ### pre single titulny obrazok
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

    #320 zaklad
    def gallery_sizes
        {
            "640" => 304,
            "533" => 480,
            "480" => 360,
            "375" => 360,
            "320" => 304
        }
    end

    def gallery_classes
        ['for_gallery', 'natural']
    end

    ### [index]
    def is_sortlink_show_all_active?
        rgx = /(^\/portfolio\/strana\-\d$)|(^\/portfolio$)/
        active = !(rgx =~ request.path).nil?
    end

    ### [index]
    def active_class_for_sortlink(skillset)
         active_link_to_class("#{portfolio_url}/#{skillset.slug}")
    end

    ### v zozname diel [index] obrazok
    def imagePreviewUrl(p, size)
        return p.portfolio_screenshot.screenshot.send(size).url#.sub(/_orig\.png$/, '.jpg')
    end

    ### len pre responsive, inak by sa nemala pustat [show]
    def imageHeaderUrlResponsive(size='', uploader='', object=nil)
        if object.nil?
            return @title_bg.send(uploader).send(size).url#.sub(/_orig\.png$/, '.jpg')
        else
            tmp = object.send(uploader).send(size).url
            res = tmp.nil? ? "" : tmp#.sub(/_orig\.png$/, '.jpg')
            return res
        end
    end

    ### [show]
    def kovodown(html)
        # spravit preload aby nerobilo n+1 query
        #tiez robi query - Rails.logger.info image[:image]
        rgx = /\&lt\;\#obrazok(\d+)\#\&gt\;/
        rgx_to_wrap = /((?:)(\&lt\;\#obrazok\d+\#\&gt\;\s*)+)/

        wrapped = html.gsub(rgx_to_wrap, '<figure> \1 </figure>')

        ret = wrapped.gsub(rgx) do |match|
            image_identificator = match.gsub(rgx, '\1').to_i
            obj = @gallery.detect { |img| img.identificator == image_identificator }
            image = obj.image
            typ = gallery_classes[obj.typ]

            r = "<picture class=\"#{typ}\">"
            gallery_sizes.each do |size, version|
                r += "<source media=\"(max-width: #{size}px)\""
                r += "srcset=\""
                retina_sizes.each_with_index do |retina_size, index|
                    url = image.send("gallery_page_size_#{version.to_s}_#{retina_size}").url
                    r += url
                    r += " #{retina_size}" if index > 0
                    r += ", " if index < retina_sizes.size-1
                end
                r += "\">"
            end
            r += "
                <img src=\"#{image.gallery_page_size_320_1x.url}\"
                     srcset=\"#{image.gallery_page_size_320_2x.url} 2x,
                            #{image.gallery_page_size_320_3x.url} 3x\"
                >
            "
            r += "</picture>"
            r
        end
=begin
        Rails.logger.info "---------------------------------"

        doc = Nokogiri::HTML(ret) { |c| c.noblanks }

        doc.xpath('//div').each do |node|
            #Rails.logger.info node.children.count
            #Rails.logger.info node
            elem_prev = nil
            node.children.each_with_index do |n, i|
                #Rails.logger.info i
                Rails.logger.info n.name
                if n.name == 'picture'
                    if elem_prev.nil?
                    else
                    end
                end
            end
        end
=end


        markdown ret
    end

end
