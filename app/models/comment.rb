class Comment < ActiveRecord::Base

    belongs_to(
        :user,
        inverse_of: :comments
    )

    belongs_to(
        :post,
        inverse_of: :comments
    )

    validates :comment, presence: true

    def relation_id
        reply_to.blank? ? id : reply_to
    end

end
