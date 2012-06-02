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

  def year_absences(year)
    required = justified = unexcused = late = 0
    semesters = school_class.school.semesters.find_all_by_end_year(year)
    absences = []
    semesters.each do |semester|
      absences += self.absences.find_all_by_semester_id(semester.id)
    end
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

  def update_password(params)
    update_attribute(:password, params[:password]) if verify_teacher_current_password(params) && validate_teacher_new_password(params)
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

  def current_absences
    absences = self.absences.find_all_by_semester_id(school_class.semester_id)
    @absences ||= {
      :required => absences.map(&:required).delete_if {|a| a.nil?}.inject(0, &:+),
      :justified => absences.map(&:justified).delete_if {|a| a.nil?}.inject(0, &:+),
      :unexcused => absences.map(&:unexcused).delete_if {|a| a.nil?}.inject(0, &:+),
      :late => absences.map(&:late).delete_if {|a| a.nil?}.inject(0, &:+)
    }
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
