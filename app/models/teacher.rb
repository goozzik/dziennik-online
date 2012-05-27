class Teacher < User

  default_scope :conditions => ["teacher = ?", true]

  has_many :school_classes
  has_many :semesters
  has_many :students
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

  def school_class_subjects
    school_class.subjects
  end

  def school_class_students
    school_class.students
  end

  def semester_descriptions
    semester.descriptions
  end

  def school_class_time_tables
    school_class.time_tables
  end

  def school_class_available_time_table_days
    school_class.available_time_table_days
  end

  def school_class_messages
    school_class.messages
  end

end
