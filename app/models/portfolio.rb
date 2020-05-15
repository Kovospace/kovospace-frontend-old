class Portfolio < ActiveRecord::Base
    extend FriendlyId
    include FriendlyIdConcern
    include ColorConcern

    EXCLUDED_SLUG_VALUES = Skillset.all.pluck(:slug)
    friendly_id_config.reserved_words.concat(EXCLUDED_SLUG_VALUES)

    has_and_belongs_to_many :skills

    ### miniatura v zozname prac
    has_one :portfolio_screenshot, dependent: :destroy
    accepts_nested_attributes_for(
        :portfolio_screenshot,
        allow_destroy: true,
        reject_if: proc { |c| c[:screenshot].blank? }
    )

    ### obrazok na headeri prace
    has_many :portfolio_titlebgs, dependent: :destroy
    accepts_nested_attributes_for(
        :portfolio_titlebgs,
        allow_destroy: true,
        reject_if: proc { |c| (c[:title_bg_desktop].blank?&&c[:title_bg_tablet].blank?&&c[:title_bg_mobile].blank?) }
    )

    ### obrazok na headeri prace - osamoteny
    has_many :portfolio_titlebg_singles, dependent: :destroy
    accepts_nested_attributes_for(
        :portfolio_titlebg_singles,
        allow_destroy: true,
        reject_if: proc { |c| (c[:title_bg].blank?) }
    )

    ### galeria
    has_many :portfolio_galleries, dependent: :destroy
    accepts_nested_attributes_for(
        :portfolio_galleries,
        allow_destroy: true,
        reject_if: proc { |c| (c[:image].blank?) }
    )

    belongs_to :skillset, inverse_of: :portfolios, counter_cache: true

    default_scope { order(realis_date: :desc) }

    scope :category_filter, -> (category_slug) {
        if category_slug.blank?
            #return self
        else
            return self
                    .joins(:skillset)
                    .where(skillsets: {
                        slug: category_slug
                    })
                    .references(:skillset)
        end
    }

    def link_sanitized
        if !(link =~ /^http\:\/\//).nil?
            return link
        else
            return "http://" + link
        end
    end

end
