class Absence < ActiveRecord::Base

  belongs_to :student
  belongs_to :semester
  belongs_to :school_class

  attr_accessible :date, :required, :justified, :unexcused, :late, :student_id

  before_create :set_semester_id, :set_school_class_id

  def self.get_weeks_from_month(date)
    weeks = []
    month = date.month
    while date.month == month do
      weeks << date.strftime('%Y-%m-%d')
      date = Chronic.parse('next monday', :now => date)
    end
    weeks
  end

  private

    def set_semester_id
      self.semester_id = student.semester_id
    end

    def set_school_class_id
      self.school_class_id = student.school_class_id
    end

end
