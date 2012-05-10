class SuperAdmin < User

  default_scope :conditions => ["super_admin = ?", true]

end
