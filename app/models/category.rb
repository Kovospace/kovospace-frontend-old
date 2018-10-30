class Category < ActiveRecord::Base

    extend FriendlyId
    include FriendlyIdConcern
	include ModelConcern
    include NestedAttributesGetterConcern
    include BlogConcern

    #serialize :sequence

    mount_uploader :title_bg, CategoryTitleBgUploader

	has_many :category_posts, inverse_of: :category
	has_many :posts, through: :category_posts

    accepts_nested_attributes_for :posts
    nested_attrs_getter_for :posts

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

    before_update :create_order

    def create_order
        @posts_attributes.each_with_index do |pa, i|
            c = CategoryPost
                .where(category_id: self.id)
                .where(post_id: pa[1]["id"])
                .first()
            # should be one always
            c.update_attribute(:sequence, i)
        end
    end

end
