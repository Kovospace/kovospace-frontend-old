class Post < ActiveRecord::Base

	extend FriendlyId
    include FriendlyIdConcern
	include ModelConcern
	include NestedAttributesGetterConcern
	include BlogConcern

	friendly_id :title, use: [:slugged, :finders]

	mount_uploader :avatar, PostAvatarUploader

	has_many(
		:post_tags,
		inverse_of: :post,
		dependent: :destroy
		# destroy references (joins) to tags in post_tags intertable, not created tags
	)
	has_many(
		:tags,
		through: :post_tags
	)
	accepts_nested_attributes_for(
		:tags,
		#allow_destroy: true,
		reject_if: lambda { |c| c[:title].blank? }
		# skip saving empty tag association if field for new tag is not filled
		# but do not raise validation error
	)

	has_many(
		:category_posts,
		inverse_of: :post,
		dependent: :destroy
	)
	has_many(
		:categories,
		through: :category_posts,
		validate: false
		# skip validations if saved using autosave of parent model (this model)
	)
	accepts_nested_attributes_for(
		:categories,
		allow_destroy: true,
		reject_if: lambda { |c| c[:title].blank? }
	)

	has_many(
        :blog_posts,
        inverse_of: :post,
        dependent: :destroy
    )
    has_many(
        :blogs,
        through: :blog_posts
        #validate: false
        # skip validations if saved using autosave of parent model (this model)
    )

	nested_attrs_getter_for :categories, :tags

	validates :text, presence: true
	validate :no_category_selected

	def no_category_selected
		if nested_selected_or_created_any?(:categories, :title)
			self.errors.add(:categories_attributes, :not_selected_or_created)
		end
		# check if post belongs to at least one category - from checkboxes or newly created
	end

end
