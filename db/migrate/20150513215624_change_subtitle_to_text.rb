class ChangeSubtitleToText < ActiveRecord::Migration
  def change
    change_column :assessments, :subtitle, :text
  end
end
