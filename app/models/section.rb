class Section < ActiveRecord::Base
  belongs_to :assessment
  has_many :questions
end
