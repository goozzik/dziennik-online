class Semester < ActiveRecord::Base

  belongs_to :teacher
  belongs_to :school_class
  attr_accessible :semester, :active, :school_class_id

  before_validation :inherit_from_school_class
  after_create :set_teacher_current_semester
  before_create :unactive_old_semester, :set_active, :set_semester_number

  private

    def set_semester_number
      self.semester = self.school_class.semesters.count + 1
    end

    def set_teacher_current_semester
      self.teacher.update_attributes(:semester_id => self.id)
    end

    def unactive_old_semester
      old_active_semester = Semester.first(:conditions => ['teacher_id = ? AND active = ?', self.teacher_id, true])
      old_active_semester.update_attributes(:active => false) if old_active_semester
    end

    def set_active
      self.active = true
    end

    def inherit_from_school_class
      self.teacher_id = self.school_class.teacher_id
    end

end
