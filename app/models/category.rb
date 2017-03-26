class Category < ActiveRecord::Base

	include ModelConcern

	has_many :category_posts, inverse_of: :category
	has_many :posts, through: :category_posts

	validates :title, presence: true

	#validate :test

	#def test
	#	Rails.logger.info " ----  #{self.posts.size}"
	#	Rails.logger.info " ----  #{self.id}"
	#end
	
end
