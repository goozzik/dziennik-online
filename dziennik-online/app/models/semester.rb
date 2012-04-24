class Semester < ActiveRecord::Base

  belongs_to :teacher
  belongs_to :school_class
  attr_accessible :semester, :active, :school_class_id

  before_validation :inherit_from_school_class
  after_create :set_teacher_current_semester
  before_create :set_unactive, :set_active

  private

    def set_teacher_current_semester
      self.teacher.update_attributes(:semester_id => self.id)
    end

    def set_unactive
      semester = Semester.first(:conditions => ['teacher_id = ? AND active = ?', self.teacher_id, true])
      semester.try('update_attributes(:active => false)')
    end

    def set_active
      self.active = true
    end

    def inherit_from_school_class
      self.teacher_id = self.school_class.teacher_id
    end

end
