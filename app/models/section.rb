class Section < ActiveRecord::Base
  belongs_to :assessment
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => :all_blank, :allow_destroy => true

  def serializable_hash(options={})
    super(:only => [:title, :subtitle], :include => :questions)
  end
end
