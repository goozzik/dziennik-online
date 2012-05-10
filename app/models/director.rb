class Director < User

  default_scope :conditions => ["director = ?", true]

  has_many :school_classes
  belongs_to :school

  attr_accessible :school_id

  def active_school_classes
    school.school_classes.find(:all, :conditions => ["active = ?", true])
  end

end
