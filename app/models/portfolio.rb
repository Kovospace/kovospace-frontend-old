class Portfolio < ActiveRecord::Base
    extend FriendlyId
    include FriendlyIdConcern
    include ColorConcern

    friendly_id :title, use: [:slugged, :finders]

    has_and_belongs_to_many :skills

    has_one :portfolio_screenshot, dependent: :destroy
    accepts_nested_attributes_for(
        :portfolio_screenshot,
        allow_destroy: true,
        reject_if: proc { |c| c[:screenshot].blank? }
    )

    has_many :portfolio_titlebgs, dependent: :destroy
    accepts_nested_attributes_for(
        :portfolio_titlebgs,
        allow_destroy: true,
        reject_if: proc { |c| (c[:title_bg].blank?&&c[:title_bg_tablet].blank?&&c[:title_bg_mobile].blank?) }
    )

    belongs_to :skillset, inverse_of: :portfolios

    default_scope { order(realis_date: :desc) }

    validates :title, presence: true
    validates_format_of :title, :without => /^\d/, multiline: true
    validates :slug, uniqueness: true

end
