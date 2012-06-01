class Director < User

  default_scope :conditions => ["director = ?", true]

  belongs_to :school

  attr_accessible :school_id

  delegate :school_classes, :to => :school

end
