class PortfolioScreenshot < ActiveRecord::Base

  include ModelConcern

  mount_uploader :screenshot, ScreenshotUploader

end
