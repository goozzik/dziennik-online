class Admin < User

  default_scope :conditions => ["admin = ?", true]

  belongs_to :school

  def school_semester
    school.semester
  end

  def school_semesters
    school.semesters
  end

end
