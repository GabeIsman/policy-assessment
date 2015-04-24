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

  def get_overall_grade
    get_grade_for_answers(self.answers.to_a)
  end

  private

    def get_grade_for_answers(answers)
      num_yes = answers.count{|a| a.value == '0'}
      num_no = answers.count{|a| a.value == '1'}
      pct = (1.0 * num_yes / (num_yes + num_no)) * 100
      if pct == 100
        'A+'
      elsif pct > 95
        'A'
      elsif pct > 90
        'A-'
      elsif pct > 87
        'B+'
      elsif pct > 83
        'B'
      elsif pct > 80
        'B-'
      elsif pct > 77
        'C+'
      elsif pct > 73
        'C'
      elsif pct > 70
        'C-'
      elsif pct > 65
        'D'
      else
        'F'
      end
    end
end
