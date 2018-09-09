class Category < ActiveRecord::Base

	include ModelConcern

	has_many :category_posts, inverse_of: :category
	has_many :posts, through: :category_posts

	validates :title, presence: true

	has_many(
        :blog_categories,
        inverse_of: :category,
        dependent: :destroy
    )
    has_many(
        :blogs,
        through: :blog_categories
        #validate: false
        # skip validations if saved using autosave of parent model (this model)
    )

	#validate :test

	#def test
	#	Rails.logger.info " ----  #{self.posts.size}"
	#	Rails.logger.info " ----  #{self.id}"
	#end

end
