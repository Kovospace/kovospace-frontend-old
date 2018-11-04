class Skill < ActiveRecord::Base

    include ModelConcern
    include ColorConcern

    has_and_belongs_to_many :portfolios

    mount_uploader :icon, SkillIconUploader

end
