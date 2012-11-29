class Teacher < User

  default_scope :conditions => ["role = ?", "teacher"]

  has_many :school_classes, :dependent => :destroy
  has_one :school_class, :conditions => ["active = ?", true]
  has_many :students, :dependent => :destroy
  has_many :documents, :as => :user, :foreign_key => "user_id"

  before_validation :set_role

  delegate :average_semestral_mark_for_semester,
           :count_semestral_marks,
           :semester_absences,
           :semester,
           :semester_fullname,
           :semesters,
           :subjects,
           :all_subjects, :to => :school_class
  delegate :current_year_semesters,
           :school_year,
           :profile_templates_names, :to => :school

  def deactivate_school_class
    school_class.deactivate if school_class
  end

  def school_class_students
    school_class.students
  end

  def school_class_fullname
    school_class.fullname
  end

  def school_class_id
    school_class.id
  end

  private

    def set_role
      self.role = "teacher"
      self.user_role = "nauczyciel"
    end

end
