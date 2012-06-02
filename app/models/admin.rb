class Admin < User

  default_scope :conditions => ["admin = ?", true]

  belongs_to :school

end
