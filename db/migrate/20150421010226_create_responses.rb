class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :email
      t.string :ip
      t.string :location

      t.timestamps null: false
    end
  end
end
