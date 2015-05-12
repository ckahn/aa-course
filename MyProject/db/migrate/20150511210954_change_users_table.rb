class ChangeUsersTable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :email
      t.rename :name, :username
    end

    add_index :users, :username, unique: true
  end
end
