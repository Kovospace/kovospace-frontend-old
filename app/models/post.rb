class Post < ActiveRecord::Base

	has_many :post_tags, inverse_of: :post, dependent: :destroy
	has_many :tags, through: :post_tags

	accepts_nested_attributes_for :tags, allow_destroy: true

end
