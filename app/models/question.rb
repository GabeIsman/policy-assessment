class Question < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :section
  has_many :answers
  default_scope { order(:order) }
end
