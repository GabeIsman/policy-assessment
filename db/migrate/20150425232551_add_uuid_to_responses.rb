class AddUuidToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :uuid, :string
  end
end
