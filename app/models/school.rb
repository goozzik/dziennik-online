#coding: utf-8
class School < ActiveRecord::Base

  MONTHS = ["Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec", "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"] 

  has_many :admins, :dependent => :destroy
  has_many :directors, :dependent => :destroy
  has_many :teachers, :dependent => :destroy
  has_many :school_classes, :dependent => :destroy
  has_many :semesters, :dependent => :destroy
  has_many :students, :dependent => :destroy
  has_many :users, :dependent => :destroy
  has_many :documents, :dependent => :destroy, :conditions => ["school_id IS NOT NULL"]
  has_many :profile_templates, :dependent => :destroy

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

  def school_classes_by_grade(grade)
    school_classes.active.find_all_by_grade(grade)
  end

  def resit_students_by_subject_template(subject_template)
    subjects = subject_template.subjects.joins(:school_class).where(["school_classes.school_id = ?", id])
    SemestralMark.where(["subject_id IN (?) AND semester_id = ? AND mark = '1'", subjects_by_subject_template(subject_template).collect(&:id), semester.id]).collect(&:student)
  end

  def classification_students_by_subject_template(subject_template)
    SemestralMark.where(["subject_id IN (?) AND semester_id = ? AND mark = 'nkl'", subjects_by_subject_template(subject_template).collect(&:id), semester.id]).collect(&:student)
  end

  def subjects_by_subject_template(subject_template)
    subject_template.subjects.joins(:school_class).where(["school_classes.school_id = ?", id])
  end

  def subject_templates
    SubjectTemplate.joins(:subjects).where(["subjects.school_class_id IN (?)", school_classes.active.collect(&:id)]).uniq
  end

  def current_year_semesters
    Time.now.month >= 9 ? semesters.find_all_by_start_year(Time.now.year) : semesters.find_all_by_end_year(Time.now.year)
  end

  def school_year
    current_year_semesters.first.years
  end

  def profile_templates_names
    profile_templates.map(&:name).uniq
  end

end
