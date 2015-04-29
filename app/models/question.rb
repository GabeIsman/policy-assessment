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

  def get_text
    self.rendered_text.nil? ? self.text : self.rendered_text.html_safe
  end

  def get_more
    self.rendered_info.nil? ? self.more_info : self.rendered_info.html_safe
  end


  def compile_markdown
    self.rendered_text = Kramdown::Document.new(self.text).to_html
    self.rendered_info = Kramdown::Document.new(self.more_info).to_html
  end
end
