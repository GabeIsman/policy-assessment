class Response < ActiveRecord::Base
  belongs_to :assessment
  has_many :answers, :dependent => :destroy
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

  def get_overall_pct
    get_pct_for_answers(self.answers.to_a)
  end

  def get_grade_for_section(section)
    get_grade_for_answers(answers_for_section(section))
  end

  private

    def get_grade_for_answers(answers)
      answers = answers.select{|a| !a.value.nil? && !a.question.nil? }
      num_good = answers.count{|a| a.value == a.question.good_answer }
      num_bad = answers.count{|a| a.value != '2' && a.value != a.question.good_answer }
      if answers.count == 0 || num_good + num_bad == 0
        return '-'
      end
      pct = (1.0 * num_good / (num_good + num_bad)) * 100
      if pct > 70
        'A'
      elsif pct > 60
        'B'
      elsif pct > 50
        'C'
      elsif pct > 40
        'D'
      else
        'F'
      end
    end

    def get_pct_for_answers(answers)
      answers = answers.select{|a| !a.value.nil? }
      num_good = answers.count{|a| a.value == a.question.good_answer }
      num_bad = answers.count{|a| a.value != '2' && a.value != a.question.good_answer }
      (1.0 * num_good / (num_good + num_bad)) * 100
    end
end
