class PortfolioGallery < ActiveRecord::Base

  belongs_to :portfolio

  mount_uploader :image, PortfolioGalleryUploader

end
