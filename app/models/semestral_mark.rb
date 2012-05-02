class SemestralMark < ActiveRecord::Base

  belongs_to :student
  belongs_to :school_class
  belongs_to :semester
  belongs_to :subject

  attr_accessible :mark, :student_id, :subject_id

  before_create :inherit_from_semester

  def self.find_all_by_students_and_semester_id_and_subject_id(students, semester_id, subject_id)
    semestral_marks = []
    students.each do |student|
      semestral_marks << SemestralMark.find_by_student_id_and_semester_id_and_subject_id(student.id, semester_id, subject_id)
    end
    semestral_marks
  end

  private

    def inherit_from_semester
      self.school_class_id = semester.school_class_id
    end

end
