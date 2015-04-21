class Answer < ActiveRecord::Base
  belongs_to :response
  belongs_to :question

  def self.create_from_question(question)
    answer = Answer.new
    answer.question = question
    answer
  end
end
