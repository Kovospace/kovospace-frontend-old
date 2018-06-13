class WorkState < ActiveRecord::Base

    has_many :skills, inverse_of: :work_state

end
