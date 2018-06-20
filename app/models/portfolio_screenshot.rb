class PortfolioScreenshot < ActiveRecord::Base

  belongs_to :portfolio

  mount_uploaders :screenshot, ScreenshotUploader

end
