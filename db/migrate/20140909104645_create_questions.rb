class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question
      t.string :a
      t.string :b
      t.string :c
      t.string :d
      t.string :correct_answer
      t.timestamps
    end
  end
end
