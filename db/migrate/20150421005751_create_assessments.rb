class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.string :title
      t.string :subtitle
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
