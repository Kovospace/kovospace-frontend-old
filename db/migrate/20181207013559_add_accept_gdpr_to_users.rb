class AddAcceptGdprToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accept_gdpr, :boolean
  end
end
