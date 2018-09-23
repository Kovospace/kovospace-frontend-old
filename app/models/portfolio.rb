class Portfolio < ActiveRecord::Base

    include ModelConcern

    has_and_belongs_to_many :skills

    has_many :portfolio_screenshots, dependent: :destroy
    accepts_nested_attributes_for(
        :portfolio_screenshots,
        allow_destroy: true,
        reject_if: proc { |c| c[:screenshot].blank? }
    )

    belongs_to :skillset, inverse_of: :portfolios

end
