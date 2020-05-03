class PortfoliosController < ApplicationController

    before_action :authorize_admin, except: [:index, :show]

    ## override
    def index
        @skillsets = Skillset.all
    end

    ## override
    def show
        @title_bg = @portfolio.portfolio_titlebgs.first
        @title_bg_single = @portfolio.portfolio_titlebg_singles.first
        @header_type = showsection_decide_titlebg_type(@portfolio)
        if @header_type == :responsive
            @images_to_switch = @portfolio.portfolio_titlebgs
        elsif @header_type == :single
            @images_to_switch = @portfolio.portfolio_titlebg_singles
        end
        find_image
    end

    def add_screenshots

    end

    def remove_screenshots

    end

    private

    def _choose_layout
        case action_name
        when "index", "show"
            return "base"
        when "new", "create", "edit", "update"
            return "admin"
        end
    end

    ## override
    def index_action
        @portfolios = Portfolio
            .category_filter(params[:skillset_id])
            .page(params[:page])
            .per(2)
    end

    def _load_vars
       @skills_all = Skill.all
       @skillsets_all = Skillset.all
       #@portfolio_screenshots = @portfolio.portfolio_screenshots.all
    end

    def _around_new
        build_if_empty :skills, :portfolio_screenshot, :portfolio_titlebgs, :portfolio_titlebg_singles
        #@portfolio.portfolio_screenshots.build
    end

    def _around_create_after_save
        build_if_empty :skills#, :portfolio_screenshots
    end

    def _around_edit
        build_if_empty :skills, :portfolio_screenshot, :portfolio_titlebgs, :portfolio_titlebg_singles
    end

    def _after_ok_redirect_to
        { controller: "admin", action: "list_portfolios" }
    end

    def showsection_decide_titlebg_type(obj)
        b = obj.portfolio_titlebgs
        c = obj.portfolio_titlebg_singles
        i = b.first ## responsive
        j = c.first ## single
        if b.blank?&&c.blank?
            return :nothing
        else
            if j.blank?
                if !i.blank?
                    ### tu je chyba preco ide tato podmienkya ???
                    if !i.title_bg_desktop.blank?&&!i.title_bg_tablet.blank?&&!i.title_bg_mobile.blank?
                        ##return :responsive
                    elsif !i.title_bg_desktop.blank?&&i.title_bg_tablet.blank?&&i.title_bg_mobile.blank?
                        return :desktop
                    elsif i.title_bg_desktop.blank?&&i.title_bg_tablet.blank?&&!i.title_bg_mobile.blank?
                        return :mobile
                    elsif !i.title_bg.blank?
                        return :desktop
                    else
                        return :missing_sth
                    end
                else
                    return :nothing
                end
            else
                ## dat full size obrazku prednost
                return :single
            end
        end
    end

    def find_image
        if params.has_key?(:obrazok)
            @title_bg = @images_to_switch.find(params[:obrazok].to_i)
        else
            @title_bg = @images_to_switch.first
        end
    end

    def _permitted_params
         params.require(:portfolio).permit(
            :id,
            :title,
            :intro,
            :description,
            :link,
            :skillset_id,
            :realis_date,
            :theme_color,
            :slug,
            skill_ids: [],
            portfolio_screenshot_attributes: [:id, :portfolio_id, :screenshot, :remove_screenshot, :screenshot_cache, :_destroy],
            portfolio_titlebgs_attributes: [
                :id, :portfolio_id,
                :title_bg_desktop, :title_bg_desktop_cache, :remove_title_bg_desktop,
                :title_bg_tablet, :title_bg_tablet_cache, :remove_title_bg_tablet,
                :title_bg_mobile, :title_bg_mobile_cache, :remove_title_bg_mobile,
                :_destroy
            ],
            portfolio_titlebg_singles_attributes: [
                :id, :portfolio_id,
                :title_bg, :title_bg_cache, :remove_title_bg,
                :_destroy
            ]
         )
    end

end
