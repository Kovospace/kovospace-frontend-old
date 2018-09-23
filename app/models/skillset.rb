class Skillset < ActiveRecord::Base

    has_many :portfolios, inverse_of: :skillset

end
