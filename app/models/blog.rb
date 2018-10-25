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

    nested_attrs_getter_for :categories, :tags

    scope :uncategorized_posts, -> {

    }

    scope :regenerate_associations, -> {
        ## z kategorii zistit dotknute blogy
        ## tym pdatnut clanky podla clankov z kategorii
    }


end
