class PortfoliosController < ApplicationController

    before_action :authorize_admin, except: [:index, :show]

    ## override
    def index
        @skillsets = Skillset.all
    end

    ## override
    def show
        @title_bgs = @portfolio.portfolio_titlebgs
    end

    def add_screenshots

    end

    def remove_screenshots

    end

    private

    def _choose_layout
        case action_name
        when "index"
            return "base"
        when "new", "create", "edit", "update"
            return "admin"
        end
    end

    ## override
    def index_action
        @portfolios = Portfolio.category_filter(params[:skillset_id]).page(params[:page]).per(2)
    end

    def _load_vars
       @skills_all = Skill.all
       @skillsets_all = Skillset.all
       #@portfolio_screenshots = @portfolio.portfolio_screenshots.all
    end

    def _around_new
        build_if_empty :skills, :portfolio_screenshot, :portfolio_titlebgs
        #@portfolio.portfolio_screenshots.build
    end

    def _around_create_after_save
        build_if_empty :skills#, :portfolio_screenshots
    end

    def _around_edit
        build_if_empty :skills, :portfolio_screenshot, :portfolio_titlebgs
    end

    def _after_ok_redirect_to
        { controller: "admin", action: "list_portfolios" }
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
                :title_bg, :title_bg_cache, :remove_title_bg,
                :title_bg_tablet, :title_bg_tablet_cache, :remove_title_bg_tablet,
                :title_bg_mobile, :title_bg_mobile_cache, :remove_title_bg_mobile,
                :_destroy
            ]
         )
    end

end
