require 'kramdown'

class Question < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :section
  has_many :answers
  before_save :compile_markdown
  default_scope { order(:order) }

  def has_more?
    self.more_info != ''
  end

  def compile_markdown
    self.rendered_text = Kramdown::Document.new(self.text).to_html
    self.rendered_info = Kramdown::Document.new(self.more_info).to_html
  end
end
