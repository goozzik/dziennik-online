# coding: utf-8
class Student < User

  default_scope :conditions => ["role = ?", "student"]

  scope :first_grade, joins(:school_class).where(["school_classes.grade = ? AND school_classes.active = ?", 1, true])
  scope :second_grade, joins(:school_class).where(["school_classes.grade = ? AND school_classes.active = ?", 2, true])
  scope :third_grade, joins(:school_class).where(["school_classes.grade = ? AND school_classes.active = ?", 3, true])
  scope :fourth_grade, joins(:school_class).where(["school_classes.grade = ? AND school_classes.active = ?", 4, true])

  belongs_to :school_class
  belongs_to :teacher

  has_many :absences, :dependent => :destroy
  has_many :marks, :dependent => :destroy
  has_many :semestral_marks, :dependent => :destroy
  has_many :average_semestral_marks, :dependent => :destroy

  attr_accessible :email, :student, :first_name, :last_name,
                  :pesel, :street, :city, :zip_code, :province,
                  :telephone, :individual, :boarding_school, :niu

  validates_presence_of :first_name, :last_name

  before_validation :set_role, :set_teacher_id, :set_school_id, :generate_username_and_password

  def self.bests_by_semester_id(semester_id)
    joins(:average_semestral_marks).where(["average_semestral_marks.semester_id = ?", semester_id]).order("average_semestral_marks.average DESC").limit(4)
  end

  def current_average
    average_semestral_marks.find_by_semester_id(school.semester.id)
  end

  def current_average_from_subject(subject)
    Mark.average_from_marks(marks.current.find_all_by_subject_id(subject))
  end

  def descriptions_by_subject_id(subject_id)
    teacher_school_class_semester_descriptions.find_all_by_subject_id(subject_id)
  end

  def semester_absences(semester)
    absences = self.absences.find_all_by_semester_id(semester)
    {
      :required => absences.map(&:required).delete_if {|a| a.nil?}.inject(0, &:+),
      :justified => absences.map(&:justified).delete_if {|a| a.nil?}.inject(0, &:+),
      :unexcused => absences.map(&:unexcused).delete_if {|a| a.nil?}.inject(0, &:+),
      :late => absences.map(&:late).delete_if {|a| a.nil?}.inject(0, &:+)
    }
  end

  def current_absences
    semester_absences(school_class.semester_id)
  end

  def semester_average(semester)
    marks = semestral_marks.find_all_by_semester_id(semester)
    (marks.map(&:mark).inject(:+) / marks.count).to_f unless marks.empty?
  end

  def count_semestral_marks(mark, semester)
    semestral_marks.find_all_by_mark_and_semester_id(mark, semester).count
  end

  def list_current_marks_by_subject_id(subject_id)
    marks.find_all_by_semester_id_and_subject_id(school_class.semester_id, subject_id).collect {|mark| mark.mark}.join(', ')
  end

  def update_password(params)
    update_attribute(:password, params[:password]) if verify_teacher_current_password(params) && validate_teacher_new_password(params)
  end

  private

    def set_teacher_id
      self.teacher_id = school_class.teacher_id
    end

    def set_school_id
      self.school_id = school_class.school_id
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

    def set_role
      self.role = "student"
    end

end
