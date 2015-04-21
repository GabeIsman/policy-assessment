class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title
      t.string :subtitle
      t.integer :assessment_id

      t.timestamps null: false
    end
  end
end
