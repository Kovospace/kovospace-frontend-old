class PortfolioTitlebgSingle < ActiveRecord::Base

    include ModelConcern

    belongs_to :portfolio

    mount_uploader :title_bg, PortfolioTitleSingleUploader

end