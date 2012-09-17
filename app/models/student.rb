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

  before_validation :set_role, :set_teacher_id, :set_school_id

  delegate :second_semester_by_year,
           :semester, :semester_id, :subjects, :to => :school_class
  delegate :school_year, :to => :school

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
    SemesterAbsence.new(self, semester)
  end

  def current_absences
    semester_absences(school_class.semester_id)
  end

  def semester_average(semester)
    marks = semestral_marks.find_all_by_semester_id(semester)
    (marks.map(&:mark).inject(:+) / marks.count).to_f unless marks.empty?
  end

  def count_semestral_marks(mark, semester)
    semestral_marks.find_all_by_mark_and_semester_id(mark.to_s, semester).count
  end

  def list_current_marks_by_subject_id(subject_id)
    marks.find_all_by_semester_id_and_subject_id(semester.id, subject_id).collect {|mark| mark.mark}.join(', ')
  end

  def update_password(params)
    update_attribute(:password, params[:password]) if verify_teacher_current_password(params) && validate_teacher_new_password(params)
  end

  def semesters
    school.current_year_semesters
  end

  def average_semestral_mark_for_semester(semester)
    average_semestral_marks.find_by_semester_id(semester).try(:average) || "--"
  end

  def average_semestral_mark_for_year(year)
    average_semestral_marks.find_by_semester_id(second_semester_by_year(year)).try(:average) || "--"
  end

  def absence_by_date(date)
    absences.find_by_date(date)
  end

  def year_absences(year)
    YearAbsence.new(self, year)
  end

  def count_year_marks(mark, year)
    count_semestral_marks(mark, second_semester_by_year(year))
  end

  def school_semesters
    school.semesters
  end

  def school_class_semester_absences(semester)
    school_class.semester_absences(semester)
  end

  def school_class_average_semestral_mark_for_semester(semester)
    school_class.average_semestral_mark_for_semester(semester)
  end

  def school_class_count_semestral_marks(mark, semester)
    school_class.count_semestral_marks(mark, semester)
  end

  def school_class_year_absences(year)
    school_class.year_absences(year)
  end

  def school_class_average_semestral_mark_for_year(year)
    school_class.average_semestral_mark_for_year(year)
  end

  def school_class_count_year_marks(mark, year)
    school_class.count_year_marks(mark, year)
  end

  private

    def set_teacher_id
      self.teacher_id = school_class.teacher_id
    end

    def set_school_id
      self.school_id = school_class.school_id
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
      self.user_role = "uczeń"
    end

end
