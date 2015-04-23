class AddSourceToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :source, :string
  end
end
