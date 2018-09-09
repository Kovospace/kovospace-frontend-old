class Blog < ActiveRecord::Base

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

end
