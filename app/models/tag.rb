class Tag < ActiveRecord::Base

	include ModelConcern

	has_many :post_tags, inverse_of: :tag
	has_many :posts, through: :post_tags

	validates :title, presence: true

end
