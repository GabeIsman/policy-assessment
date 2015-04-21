class AddAssessmentIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :assessment_id, :integer
  end
end
