class AddRenderdSubtitleToAssessment < ActiveRecord::Migration
  def change
    add_column :assessments, :rendered_subtitle, :text
  end
end
