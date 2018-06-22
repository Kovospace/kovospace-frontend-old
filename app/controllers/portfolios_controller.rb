class PortfoliosController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update]

    def add_screenshots

    end

    def remove_screenshots

    end

    private

    def _load_vars
       @skills_all = Skill.all
       #@portfolio_screenshots = @portfolio.portfolio_screenshots.all
    end

    def _around_new
        build_if_empty :skills, :portfolio_screenshots
        #@portfolio.portfolio_screenshots.build
    end

    def _around_create_after_save
        build_if_empty :skills#, :portfolio_screenshots
    end

    def _around_edit
        build_if_empty :skills, :portfolio_screenshots
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
            skill_ids: [],
            portfolio_screenshots_attributes: [:id, :portfolio_id, :screenshot, :remove_screenshot, :screenshot_cache, :_destroy]
         )
    end

end
