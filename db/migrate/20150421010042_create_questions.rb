class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.text :more_info
      t.integer :section_id
      t.integer :assessment_id
      t.string :type

      t.timestamps null: false
    end
  end
end
