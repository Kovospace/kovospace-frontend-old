class AddTitleToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :title, :text
  end
end
