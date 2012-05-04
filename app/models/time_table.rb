class TimeTable < ActiveRecord::Base

  belongs_to :school_class
  has_many :lessons

  attr_accessible :week_day, :lessons_attributes
  accepts_nested_attributes_for :lessons

end
