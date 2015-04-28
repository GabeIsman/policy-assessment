class Assessment < ActiveRecord::Base
  has_many :questions
  has_many :sections
  has_many :responses
  belongs_to :user
  accepts_nested_attributes_for :sections, :allow_destroy => true, :reject_if => :all_blank

  def as_json(options={})
    super(:only => [:title, :subtitle], :include => :sections)
  end
end
