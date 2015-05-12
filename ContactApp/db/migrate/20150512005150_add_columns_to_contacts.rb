class AddColumnsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :favorited, :boolean
    add_column :contact_shares, :favorited, :boolean
  end
end
