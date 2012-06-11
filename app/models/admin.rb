class Admin < User

  default_scope :conditions => ["role = ?", "admin"]

  belongs_to :school

  before_validation :set_role

  private

    def set_role
      self.role = "admin"
    end

end
