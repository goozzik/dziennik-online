class Director < User

  default_scope :conditions => ["role = ?", "director"]

  belongs_to :school

  has_many :documents, :as => :user, :foreign_key => "user_id"

  before_validation :set_role

  delegate :school_classes_by_grade,
           :current_year_semesters,
           :school_year, :to => :school

  def school_classes
    school.school_classes.active
  end

  def school_documents
    school.documents
  end

  private

    def set_role
      self.role = "director"
      self.user_role = "dyrektor"
    end


end
