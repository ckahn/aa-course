class ChangeAlbumsColumns < ActiveRecord::Migration
  def change
    remove_column :albums, :recorded
    add_column :albums, :live, :boolean, null: false
  end
end
