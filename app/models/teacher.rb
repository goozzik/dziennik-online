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

  def deactivate_school_class
    school_class.deactivate if school_class
  end

end
