class SuperAdmin < User

  default_scope :conditions => ["role = ?", "superadmin"]

  before_validation :set_role

  private

    def set_role
      self.role = "superadmin"
    end

end
