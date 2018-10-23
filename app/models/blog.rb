class Blog < ActiveRecord::Base
    extend FriendlyId
    include FriendlyIdConcern

	belongs_to :user

    friendly_id :title, use: [:slugged, :finders]

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

    validates :title, presence: true, uniqueness: true
    validates_format_of :title, :without => /^\d/, multiline: true
    validates :slug, uniqueness: true

    scope :uncategorized_posts, -> {

    }

    scope :regenerate_associations, -> {
        ## z kategorii zistit dotknute blogy
        ## tym pdatnut clanky podla clankov z kategorii
    }



end
