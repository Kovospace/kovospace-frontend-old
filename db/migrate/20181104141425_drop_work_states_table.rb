class DropWorkStatesTable < ActiveRecord::Migration
  def change
    drop_table :work_states
  end
end
