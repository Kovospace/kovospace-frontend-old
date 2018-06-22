class PortfolioScreenshot < ActiveRecord::Base

  include ModelConcern

  #attr_accessor :screenshot, :screenshot_cache

  belongs_to :portfolio

  mount_uploader :screenshot, ScreenshotUploader

end
