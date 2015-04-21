class Response < ActiveRecord::Base
  belongs_to :assessment
  has_many :answers
  accepts_nested_attributes_for :answers

  def prepare_new_answers
    self.answers = self.assessment.questions.map do |question|
      answer = Answer.create_from_question(question)
    end
  end
end
