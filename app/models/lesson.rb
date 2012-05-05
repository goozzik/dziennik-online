class Lesson < ActiveRecord::Base

  belongs_to :time_table
  belongs_to :subject

  attr_accessible :subject_id, :number

end
