class Comment < ActiveRecord::Base

    #require 'version_sorter'

    belongs_to(
        :user,
        inverse_of: :comments
    )

    belongs_to(
        :post,
        inverse_of: :comments
    )

    validates :comment, presence: true

    #default_scope { order(id: :asc) }

    def relation_id
        reply_to.blank? ? id : reply_to
    end

end
