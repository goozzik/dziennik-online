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

  def best_students_by_grade(grade)
    case grade
    when 1
      students.first_grade.bests_by_semester_id(semester.id)
    when 2
      students.second_grade.bests_by_semester_id(semester.id)
    when 3
      students.third_grade.bests_by_semester_id(semester.id)
    when 4
      students.fourth_grade.bests_by_semester_id(semester.id)
    end
  end

  def resit_students_by_subject_template(subject_template)
    subjects = subject_template.subjects.joins(:school_class).where(["school_classes.school_id = ?", id])
    _students = SemestralMark.where(["subject_id IN (?) AND semester_id = ? AND mark = 1", subjects.collect(&:id), semester.id]).collect(&:student)
  end

  def subject_templates
    SubjectTemplate.joins(:subjects).where(["subjects.school_class_id IN (?)", school_classes.active.collect(&:id)]).uniq
  end

end
