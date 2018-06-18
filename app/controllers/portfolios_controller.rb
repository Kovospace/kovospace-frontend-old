class PortfoliosController < ApplicationController

    layout "admin", only: [:new, :create, :edit, :update]

    private

    def _after_ok_redirect_to
        { controller: "admin", action: "list_portfolios" }
    end

    def _permitted_params
         params[:portfolio].permit(

         )
    end

end
