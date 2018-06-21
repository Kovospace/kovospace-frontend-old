class PortfolioScreenshot < ActiveRecord::Base

  include ModelConcern

  belongs_to :portfolio

  mount_uploader :screenshot, ScreenshotUploader

end
