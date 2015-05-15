class AddColumnsToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :recorded, :string, null: false
    add_column :albums, :name, :string, null: false
  end
end
