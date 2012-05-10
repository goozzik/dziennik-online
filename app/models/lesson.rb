class Lesson < ActiveRecord::Base

  belongs_to :time_table
  belongs_to :subject

  attr_accessible :subject_id, :number

  def subject_name
    subject.name
  end

end
