class Semester < ActiveRecord::Base

  belongs_to :teacher
  belongs_to :school_class
  attr_accessible :semester, :active, :school_class_id

  before_validation :inherit_from_school_class
  after_create :set_teacher_current_semester

  private

    def set_teacher_current_semester
      self.teacher.update_attributes(:semester_id => self.id)
    end

    def inherit_from_school_class
      self.teacher_id = self.school_class.teacher_id
    end

end
