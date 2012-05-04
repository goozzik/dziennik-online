class Lesson < ActiveRecord::Base

  belongs_to :time_table

  attr_accessible :subject_id

end
