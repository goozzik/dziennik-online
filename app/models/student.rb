class Student < User

  default_scope :conditions => ["student = ?", true]
  belongs_to :school_class

  attr_accessible :email, :student, :first_name, :last_name, :pesel, :street, :city, :zip_code, :province, :telephone, :individual, :boarding_school

  before_validation :set_student
  validate :is_student?

  before_create :inherit_from_school_class

  def average_from_subject(subject_id, semester_id)
    marks = Mark.find_all_by_student_id_and_subject_id_and_semester_id(self.id, subject_id, semester_id).collect { |mark| mark.mark.to_f }
    unless marks.empty?
      sum = marks.inject { |sum, element| sum + element }
      sum / marks.count
    else
      0.0
    end
  end

  private

    def set_student
      self.student = true
    end

    def is_student?
      self.student
    end

    def inherit_from_school_class
      self.teacher_id = self.school_class.teacher_id
    end


end
