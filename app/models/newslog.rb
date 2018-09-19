class Newslog < ActiveRecord::Base

    scope :in_order, -> { order(created_at: :asc) }

    scope :last3, -> { in_order.last(3).reverse }

end
