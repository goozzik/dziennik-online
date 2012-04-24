class Teacher < User

  has_many :school_classes
  attr_accessible :class_id

  def school_class
    SchoolClass.find(self.class_id)
  end

end
