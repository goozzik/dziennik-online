class Director < User

  default_scope :conditions => ["role = ?", "director"]

  belongs_to :school

  has_many :documents, :as => :user, :foreign_key => "user_id"

  before_validation :set_role

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
