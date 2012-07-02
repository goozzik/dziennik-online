class AverageSemestralMark < ActiveRecord::Base

  belongs_to :student
  belongs_to :semester

  attr_accessible :student_id, :semester_id

  before_validation :set_school_class_id

  def update_average
    marks = SemestralMark.find_all_by_student_id_and_semester_id(student, semester)
    update_attribute(:average, marks.map(&:mark).collect(&:to_i).inject(:+).to_f / marks.count)
  end

  private

    def set_school_class_id
      self.school_class_id = student.school_class_id
    end

end
