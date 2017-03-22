class Category < ActiveRecord::Base

	has_many :category_posts, inverse_of: :category
	has_many :posts, through: :category_posts

	validates :title, presence: true
	
end
