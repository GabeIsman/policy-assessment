class Response < ActiveRecord::Base
  belongs_to :assessment
  has_many :answers
  accepts_nested_attributes_for :answers

  def prepare_new_answers
    self.answers = self.assessment.questions.map do |question|
      answer = Answer.create_from_question(question)
    end
  end

  def answers_for_section(section)
    self.answers.to_a.select do |answer|
      answer.question.section_id == section.id
    end
  end
end
