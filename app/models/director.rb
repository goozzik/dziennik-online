class Director < User

  default_scope :conditions => ["director = ?", true]

  belongs_to :school

  attr_accessible :school_id

  def school_classes
    school.school_classes.active
  end

end
