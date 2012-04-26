class Teacher < User

  default_scope :conditions => ["teacher = ?", true]

  has_many :school_classes
  has_many :semesters
  attr_accessible :school_class_id, :semester_id

  def school_class
    if self.school_class_id
      SchoolClass.find(self.school_class_id)
    else
      return nil
    end
  end

  def semester
    if self.semester_id
      Semester.find(self.semester_id)
    else
      return nil
    end
  end

end
