class Assessment < ActiveRecord::Base
  has_many :questions
  has_many :sections
  accepts_nested_attributes_for :sections
  accepts_nested_attributes_for :questions, :reject_if => :all_blank, :allow_destroy => true
end
