class Skillset < ActiveRecord::Base
    extend FriendlyId
    include FriendlyIdConcern

    has_many :portfolios, inverse_of: :skillset

    friendly_id :title, use: [:slugged, :finders]

    validates :title, presence: true, uniqueness: true
    validates_format_of :title, :without => /^\d/, multiline: true
    validates :slug, uniqueness: true

    default_scope { order(portfolios_count: :desc) }

end
