class Absence < ActiveRecord::Base

  belongs_to :student
  belongs_to :semester
  belongs_to :school_class

  attr_accessible :date, :required, :justified, :unexcused, :late, :student_id, :semester_id

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

  def self.find_all_by_students_and_dates(students, dates)
    absences = []
    students.each_with_index do |student, i|
      absences[i] = []
      dates.each_with_index do |date, j|
        absences[i][j] = Absence.find_by_student_id_and_date(student.id, date)
      end
    end
    absences
  end

  def self.percentage(required, justified, unexcused)
    sprintf("%1.2f", (required - (justified + unexcused)).to_f / required * 100)
  end

  private

    def set_semester_id
      self.semester_id = student.teacher_school_class_semester.id
    end

    def set_school_class_id
      self.school_class_id = student.school_class_id
    end

end
