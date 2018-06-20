class Portfolio < ActiveRecord::Base

    include ModelConcern

    attr_accessor :remove_screenshot

    #mount_uploaders :screenshots, ScreenshotsUploader
    #serialize :screenshots, JSON # If you use SQLite, add this line.

    has_and_belongs_to_many :skills

    has_many :portfolio_screenshots
    accepts_nested_attributes_for :portfolio_screenshots

end
