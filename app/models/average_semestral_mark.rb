class AverageSemestralMark < ActiveRecord::Base

  belongs_to :student
  belongs_to :semester

  attr_accessible :student_id, :semester_id

  before_validation :set_school_class_id

  def update_average
    update_attribute(:average, semestral_marks.map(&:mark).collect(&:to_i).inject(:+).to_f / semestral_marks.count) if countable?
  end

  private

    def countable?
      semestral_marks.count != 0
    end

    def semestral_marks
      student.semestral_marks.where("semester_id = ? AND mark != ?", semester_id, "zw")
    end

    def set_school_class_id
      self.school_class_id = student.school_class_id
    end

end
