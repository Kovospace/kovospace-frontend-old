class Skill < ActiveRecord::Base

    belongs_to :work_state, inverse_of: :skills

end
