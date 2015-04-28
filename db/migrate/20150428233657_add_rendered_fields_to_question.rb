class AddRenderedFieldsToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :rendered_text, :text
    add_column :questions, :rendered_info, :text
  end
end
