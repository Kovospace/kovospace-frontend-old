class AddSlugToSkillset < ActiveRecord::Migration
  def change
    add_column :skillsets, :slug, :string
  end
end
