class AddGoodAnswerToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :good_answer, :string
  end
end
