require 'kramdown'

class Assessment < ActiveRecord::Base
  has_many :questions
  has_many :sections
  has_many :responses
  belongs_to :user
  accepts_nested_attributes_for :sections, :allow_destroy => true, :reject_if => :all_blank
  before_save :compile_markdown

  def as_json(options={})
    super(:only => [:title, :subtitle], :include => :sections)
  end

  def to_csv
    questions = sections.map{|s| s.questions }.flatten
    questions_header = questions.map{|q| q.text}
    questions_order = Hash[questions.map.with_index{|q, index| [q.id, index]}]
    qhash = Hash[questions.map{|q| [q.id, q]}]
    CSV.generate do |csv|
      csv << ['City', 'State', 'Email', 'Zip', 'Overall Grade', 'Percentage'].concat(questions_header).concat(questions_header)
      responses.each do |r|
        answers = r.answers
          .select{|a| !questions_order[a.question_id].nil?}
          .sort{|a, b| questions_order[a.question_id] - questions_order[b.question_id]}
        answer_values = answers.map{|a| get_answer_value(a, qhash) }
        answer_sources = answers.map{|a| a.source }
        csv << [r.city || '', r.state || '', r.email || '', r.zip || '', r.get_overall_grade, r.get_overall_pct].concat(answer_values).concat(answer_sources)
      end
    end
  end

  def get_subtitle
    self.rendered_subtitle.nil? ? self.subtitle : self.rendered_subtitle.html_safe
  end

  private

    def get_answer_value(answer, qhash)
      return '' if answer.value.nil?
      question = qhash[answer.question_id]
      question.good_answer == answer.value ? '1' : '0'
    end

    def compile_markdown
      self.rendered_subtitle = Kramdown::Document.new(self.subtitle).to_html
    end
end
