class Skill < ActiveRecord::Base

    belongs_to :work_state, inverse_of: :skills

    has_and_belongs_to_many :portfolios

    mount_uploader :icon, SkillIconUploader

end
