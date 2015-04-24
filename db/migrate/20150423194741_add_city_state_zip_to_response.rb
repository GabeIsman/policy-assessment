class AddCityStateZipToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :city, :string
    add_column :responses, :state, :string, limit: 2
    add_column :responses, :zip, :integer, limit: 5
  end
end
