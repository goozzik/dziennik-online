class Teacher < User

  default_scope :conditions => ["teacher = ?", true]

  has_many :school_classes, :dependent => :destroy
  has_many :students, :dependent => :destroy

  def school_class
    if school_class = school_classes.find_by_active(true)
      school_class
    else
      return nil
    end
  end

  def school_class_semester
    school_class.semester
  end

  def school_semesters
    school.semesters
  end

  def school_class_subjects
    school_class.subjects
  end

  def school_class_students
    school_class.students
  end

  def school_class_semester_descriptions
    school_class_semester.descriptions
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

  def school_school_classes
    school.school_classes
  end

  def deactivate_school_class
    school_class.deactivate if school_class
  end

  def school_class_activate_semester(semester)
    school_class.activate_semester(semester)
  end

  def school_class_semester_marks
    school_class.semester_marks
  end

end
