class Teacher < User

  default_scope :conditions => ["role = ?", "teacher"]

  has_many :school_classes, :dependent => :destroy
  has_many :students, :dependent => :destroy
  has_many :documents, :as => :user, :foreign_key => "user_id"

  before_validation :set_role

  def school_class
    if school_class = school_classes.find_by_active(true)
      school_class
    else
      return nil
    end
  end

  def deactivate_school_class
    school_class.deactivate if school_class
  end

  private

    def set_role
      self.role = "teacher"
    end

end
