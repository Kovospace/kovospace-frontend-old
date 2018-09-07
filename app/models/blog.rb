class Blog < ActiveRecord::Base

	belongs_to :user

    mount_uploader :blog_bg, BlogTitleBgUploader

end
