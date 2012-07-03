class Admin < User

  AVAILABLE_ROLES = %w[nauczyciel administrator dyrektor]

  default_scope :conditions => ["role = ?", "admin"]

  belongs_to :school

  before_validation :set_role

  delegate :semesters, :to => :school

  private

    def set_role
      self.role = "admin"
      self.user_role = "administrator"
    end

end
