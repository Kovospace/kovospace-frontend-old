class AddAcceptGdprToConcact < ActiveRecord::Migration
  def change
    add_column :contacts, :accept_gdpr, :boolean
    add_column :contacts, :opt_out_token, :string
    add_column :contacts, :opt_out_pass, :string
  end
end
