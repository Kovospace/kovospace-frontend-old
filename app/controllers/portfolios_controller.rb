class PortfoliosController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update]

    def index
        @skillsets = Skillset.all
    end

    def add_screenshots

    end

    def remove_screenshots

    end

    private

    def _load_vars
       @skills_all = Skill.all
       @skillsets_all = Skillset.all
       #@portfolio_screenshots = @portfolio.portfolio_screenshots.all
    end

    def _around_new
        build_if_empty :skills, :portfolio_screenshot
        #@portfolio.portfolio_screenshots.build
    end

    def _around_create_after_save
        build_if_empty :skills#, :portfolio_screenshots
    end

    def _around_edit
        build_if_empty :skills, :portfolio_screenshot
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
            :alt_text,
            :realis_date,
            :theme_color,
            :slug,
            :title_bg,
            :title_bg_cache,
            skill_ids: [],
            portfolio_screenshot_attributes: [:id, :portfolio_id, :screenshot, :remove_screenshot, :screenshot_cache, :_destroy]
         )
    end

end
