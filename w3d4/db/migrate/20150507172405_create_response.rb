class CreateResponse < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :answerer_id, null: false
      t.integer :answer_choice_id, null: false

      t.timestamps
    end
  end
end
