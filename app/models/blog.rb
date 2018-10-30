class Blog < ActiveRecord::Base

    extend FriendlyId
    include FriendlyIdConcern
    include ModelConcern
    include NestedAttributesGetterConcern
    include BlogConcern

	belongs_to :user

    mount_uploader :title_bg, BlogTitleBgUploader

    has_many(
        :blog_categories,
        inverse_of: :blog,
        dependent: :destroy
    )
    has_many(
        :categories,
        through: :blog_categories
        #validate: false
        # skip validations if saved using autosave of parent model (this model)
    )
    accepts_nested_attributes_for(
        :categories,
        allow_destroy: true,
        reject_if: lambda { |c| c[:title].blank? }
    )

    has_many(
        :blog_posts,
        inverse_of: :blog,
        dependent: :destroy
    )
    has_many(
        :posts,
        through: :blog_posts
        #validate: false
        # skip validations if saved using autosave of parent model (this model)
    )

    has_many(
        :blog_tags,
        inverse_of: :blog#,
        #dependent: :destroy
    )
    has_many(
        :tags,
        through: :blog_tags
        #validate: false
        # skip validations if saved using autosave of parent model (this model)
    )
    accepts_nested_attributes_for(
        :tags,
        #allow_destroy: true,
        reject_if: lambda { |c| c[:title].blank? }
        # skip saving empty tag association if field for new tag is not filled
        # but do not raise validation error
    )

    nested_attrs_getter_for :categories, :tags

    def category_orders=(orders)
        @category_orders = orders
    end

    before_save :order_categories

    scope :uncategorized_posts, -> {

    }

    scope :regenerate_associations, -> {
        ## z kategorii zistit dotknute blogy
        ## tym pdatnut clanky podla clankov z kategorii
    }

    def order_categories
        @category_orders.each_with_index do |co, i|
            c = BlogCategory
                .where(blog_id: self.id)
                .where(category_id: co[1]["id"])
                .first()
            # should be one always
            c.update_attribute(:sequence, i)
        end
    end


end
