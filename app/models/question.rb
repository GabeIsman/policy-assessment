class Question < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :section
  has_many :answers

  def get_text_for_choice(num)
    ['Strongly Disagree', 'Disagree', 'Neutral', 'Agree', 'Strongly Agree', 'Don\'t know'][num - 1]
  end
end
