class Absence < ActiveRecord::Base

  belongs_to :student
  belongs_to :semester

  attr_accessible :date, :required, :justified, :unexcused, :late, :student_id, :semester_id

  before_create :set_semester_id

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

  def student_teacher_school_class_semester
    student.teacher_school_class_semester
  end

  private

    def set_semester_id
      self.semester_id = student_teacher_school_class_semester
    end

end
