# coding: utf-8
class Student < User

  default_scope :conditions => ["student = ?", true], :order => 'last_name ASC'

  belongs_to :school_class
  belongs_to :teacher

  has_many :absences, :dependent => :destroy
  has_many :marks, :dependent => :destroy
  has_many :semestral_marks, :dependent => :destroy

  attr_accessible :email, :student, :first_name, :last_name,
                  :pesel, :street, :city, :zip_code, :province,
                  :telephone, :individual, :boarding_school, :niu

  validate :validate_student
  validates_presence_of :first_name, :last_name

  before_create :set_teacher_id, :set_school_id, :set_student, :generate_username_and_password

  def average_from_subject(subject_id)
    average_from_marks(marks_by_descriptions_by_subject_id(subject_id))
  end

  def average_from_marks(marks)
    unless marks.empty?
      sum = marks.inject { |sum, element| sum + element }
      sum / marks.count
    else
      0.0
    end
  end

  def marks_by_descriptions_by_subject_id(subject_id)
    marks = []
    descriptions_by_subject_id(subject_id).each do |description|
      marks += description.marks.find_all_by_student_id(id).collect { |mark| mark.mark.to_f }
    end
    marks
  end

  def descriptions_by_subject_id(subject_id)
    teacher_school_class_semester_descriptions.find_all_by_subject_id(subject_id)
  end

  def teacher_school_class_semester_descriptions
    teacher.school_class_semester_descriptions
  end

  def sumarize_required_absences(absences)
    required = 0
    absences.each { |absence| required += absence.required if absence && absence.required }
    required
  end

  def sumarize_justified_absences(absences)
    justified = 0
    absences.each { |absence| justified += absence.justified if absence && absence.justified }
    justified
  end

  def sumarize_unexcused_absences(absences)
    unexcused = 0
    absences.each { |absence| unexcused += absence.unexcused if absence && absence.unexcused }
    unexcused
  end

  def semester_absences(semester_id)
    required = justified = unexcused = late = 0
    absences = absences.find_all_by_semester_id(semester_id)
    absences.each do |absence|
      required += absence.required if absence.required
      justified += absence.justified if absence.justified
      unexcused += absence.unexcused if absence.unexcused
      late += absence.late if absence.late
    end
    percentage = sprintf("%1.2f", (required - (justified + unexcused)).to_f / required * 100)
    { :percentage => percentage == "NaN" ? "--" : percentage,
      :required => required,
      :justified => justified,
      :unexcused => unexcused,
      :late => late
    }
  end

  def subjects
    school_class.subjects
  end

  def time_tables
    school_class.time_tables
  end

  def update_password(params)
    update_attribute(:password, params[:password]) if verify_teacher_current_password(params) && validate_teacher_new_password(params)
  end

  def teacher_school_class_semester
    teacher.school_class_semester
  end

  def school_class_semester
    school_class.semester
  end

  private

    def set_student
      self.student = true
    end

    def set_teacher_id
      self.teacher_id = school_class.teacher_id
    end

    def set_school_id
      self.school_id = school_class.school_id
    end

    def validate_student
      self.student
    end

    def generate_username_and_password
      begin
        username = rand(36**10).to_s(36)
      end unless User.find_by_username(username)
      self.username = username
      self.password = username
    end

    def verify_teacher_current_password(params)
      unless params[:current_password].empty?
        unless teacher.valid_password?(params[:current_password])
          errors.add(:current_password, "błędne hasło")
          return false
        end
      else
        errors.add(:current_password, "nie może być puste")
        return false
      end
      return true
    end

    def validate_teacher_new_password(params)
      unless params[:password].empty?
        unless params[:password].length < 6
          unless params[:password] == params[:password_confirmation]
            errors.add(:password_confirmation, "potwierdzenie hasła nie zgadza się")
            return false
          end
        else
          errors.add(:password, "za krótkie")
          return false
        end
      else
        errors.add(:password, "nie może być puste")
        return false
      end
      return true
    end

end
