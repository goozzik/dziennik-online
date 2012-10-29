class Absence < ActiveRecord::Base

  default_scope :order => 'month ASC, week ASC'

  belongs_to :student
  belongs_to :semester
  belongs_to :school_class

  attr_accessible :month, :week, :required, :justified, :unexcused, :late, :student_id

  before_create :set_semester_id, :set_school_class_id

  def self.previous_month(month)
    month.to_i != 1 ? month.to_i - 1 : 12
  end

  def self.next_month(month)
    month.to_i != 12 ? month.to_i + 1 : 1
  end

  private

    def set_semester_id
      self.semester_id = student.semester_id
    end

    def set_school_class_id
      self.school_class_id = student.school_class_id
    end

end
