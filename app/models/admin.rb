class Admin < User

  default_scope :conditions => ["admin = ?", true]

end
