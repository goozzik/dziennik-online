class Director < User

  default_scope :conditions => ["director = ?", true]

end
