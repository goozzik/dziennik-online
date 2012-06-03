class School < ActiveRecord::Base

  has_many :admins, :dependent => :destroy
  has_many :directors, :dependent => :destroy
  has_many :teachers, :dependent => :destroy
  has_many :school_classes, :dependent => :destroy
  has_many :semesters, :dependent => :destroy
  has_many :students, :dependent => :destroy

  def semester
    semesters.find_by_active(true)
  end

  def deactivate_semester
    semester.deactivate if semester
  end

  def best_active_students_by_grade(grade)
    case grade
    when 1
      students.first_grade_active.joins(:average_semestral_marks).where(["average_semestral_marks.semester_id = ?", semester.id]).order("average_semestral_marks.average ASC").limit(4)
    when 2
      students.second_grade_active.joins(:average_semestral_marks).where(["average_semestral_marks.semester_id = ?", semester.id]).order("average_semestral_marks.average ASC").limit(4)
    when 3
      students.third_grade_active.joins(:average_semestral_marks).where(["average_semestral_marks.semester_id = ?", semester.id]).order("average_semestral_marks.average DESC").limit(4)
    when 4
      students.fourth_grade_active.joins(:average_semestral_marks).where(["average_semestral_marks.semester_id = ?", semester.id]).order("average_semestral_marks.average ASC").limit(4)
    end
  end

end
