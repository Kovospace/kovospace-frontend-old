class Newslog < ActiveRecord::Base

	attr_reader :preview

    scope :in_order, -> { order(created_at: :asc) }

    scope :last3, -> { in_order.last(3).reverse }

    def preview
    	return txt.first(512)
    end

end
