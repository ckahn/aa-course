class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body

      t.timestamps null: false
    end
  end
end