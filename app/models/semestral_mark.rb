class SemestralMark < ActiveRecord::Base

  belongs_to :student
  belongs_to :semester
  belongs_to :subject

  attr_accessible :mark, :student_id, :subject_id, :semester_id

  validates :mark, :presence => true
  validates :student_id, :presence => true
  validates :subject_id, :presence => true

  before_create :set_semester_id

  def self.find_all_by_students_and_semester_id_and_subject_id(students, semester_id, subject_id)
    semestral_marks = []
    students.each do |student|
      semestral_marks << SemestralMark.find_by_student_id_and_semester_id_and_subject_id(student.id, semester_id, subject_id)
    end
    semestral_marks
  end

  def student_teacher_school_class_semester
    student_teacher.school_class_semester
  end

  def student_teacher
    student.teacher
  end

  private

    def set_semester_id
      self.semester_id = student_teacher_school_class_semester.id
    end

end
