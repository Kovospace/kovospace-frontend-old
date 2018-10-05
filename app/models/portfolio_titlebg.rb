class PortfolioTitlebg < ActiveRecord::Base

    include ModelConcern

    belongs_to :portfolio

    mount_uploader :title_bg, PortfolioTitleUploader
    mount_uploader :title_bg_tablet, PortfolioTitleTabletUploader
    mount_uploader :title_bg_mobile, PortfolioTitleMobileUploader

end
