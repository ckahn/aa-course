class CreateAnswerChoice < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.integer :question_id, null: false
      t.text :text, null: false

      t.timestamps
    end
  end
end
