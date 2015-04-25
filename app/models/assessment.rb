class Assessment < ActiveRecord::Base
  has_many :questions
  has_many :sections
  belongs_to :user
  accepts_nested_attributes_for :sections, :allow_destroy => true, :reject_if => :all_blank
end
