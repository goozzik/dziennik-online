class Teacher < User

  has_many :school_classes
  has_many :semesters
  attr_accessible :school_class_id, :semester_id

  def school_class
    SchoolClass.find(self.school_class_id)
  end

  def semester
    Semester.find(self.semester_id)
  end

end
