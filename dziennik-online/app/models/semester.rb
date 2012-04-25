class Semester < ActiveRecord::Base

  belongs_to :teacher
  belongs_to :school_class
  attr_accessible :semester, :active, :school_class_id
  default_scope :order => 'created_at ASC'

  before_create :inherit_from_school_class, :unactive_old_semester, :set_active, :set_semester_number
  after_create :set_teacher_current_semester_and_class

  before_destroy :unset_teacher_semester_id, :if => :active

  def activate
    Semester.deactivate(self.teacher_id)
    self.update_attributes(:active => true)
    self.teacher.update_attributes(:semester_id => self.id)
    self.school_class.activate if self.school_class != self.teacher.school_class
  end

  def self.deactivate(teacher_id)
    active_semester = Semester.first(:conditions => ['teacher_id = ? AND active = ?', teacher_id, true])
    active_semester.update_attributes(:active => false) if active_semester
  end

  private

    def inherit_from_school_class
      self.teacher_id = self.school_class.teacher_id
    end

    def unactive_old_semester
      old_active_semester = Semester.first(:conditions => ['teacher_id = ? AND active = ?', self.teacher_id, true])
      old_active_semester.update_attributes(:active => false) if old_active_semester
    end

    def set_active
      self.active = true
    end

    def set_semester_number
      self.semester = self.school_class.semesters.count + 1
    end

    def set_teacher_current_semester_and_class
      self.teacher.update_attributes(:semester_id => self.id, :school_class_id => self.school_class_id)
    end

    def unset_teacher_semester_id
      self.teacher.update_attributes(:semester_id => nil)
    end

end
