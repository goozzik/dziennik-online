class Director < User

  default_scope :conditions => ["role = ?", "director"]

  belongs_to :school

  has_many :documents, :as => :user, :foreign_key => "user_id"

  before_validation :set_role

  delegate :school_classes_by_grade,
           :current_year_semesters,
           :semester,
           :school_year,
           :subject_templates, :to => :school

  def school_classes
    school.school_classes.active
  end

  def school_documents
    school.documents
  end

  def school_classification_students_by_subject_template(subject_template)
    school.classification_students_by_subject_template(subject_template)
  end

  def school_resit_students_by_subject_template(subject_template)
    school.resit_students_by_subject_template(subject_template)
  end

  private

    def set_role
      self.role = "director"
      self.user_role = "dyrektor"
    end


end
