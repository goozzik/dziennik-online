# coding: utf-8
class SchoolClass < ActiveRecord::Base

  default_scope :order => 'yearbook DESC'

  scope :active, where(:active => true)

  belongs_to :school
  belongs_to :teacher
  belongs_to :profile_template

  has_many :subjects, :dependent => :destroy
  has_many :students, :dependent => :destroy, :order => "last_name ASC"
  has_many :time_tables, :dependent => :destroy
  has_many :documents, :dependent => :destroy, :conditions => ["school_class_id IS NOT NULL"]
  has_many :messages, :dependent => :destroy
  has_many :absences, :dependent => :destroy
  has_many :semestral_marks, :dependent => :destroy
  has_many :average_semestral_marks, :dependent => :destroy

  attr_accessible :letter, :profile, :yearbook, :period, :grade, :semester_id

  validates_presence_of :letter, :profile, :yearbook, :period

  before_validation :set_school_id, :set_semester_id, :set_grade, :set_profile_template_id, :on => :create
  before_create :deactivate_old_school_class, :set_active
  after_create :create_subjects_from_profile_template
  before_destroy :unset_teacher_school_class_id

  delegate :profile_templates, :to => :school

  WEEK_DAYS = {0 => 'Niedziela',
               1 => 'Poniedziałek',
               2 => 'Wtorek',
               3 => 'Środa',
               4 => 'Czwartek',
               5 => 'Piątek',
               6 => 'Sobota'}

  def absences_by_current_school_semester
    semester_absences(school.semester)
  end

  def fullname
    "#{grade} #{letter} #{profile} #{yearbook}"
  end

  def name
    "#{grade} #{letter}"
  end

  def available_time_table_days
    WEEK_DAYS.delete_if { |i, week_day| time_tables.find_by_week_day_and_school_class_id(i, id) }
  end

  def available_subject_templates
    SubjectTemplate.all.delete_if { |template| subjects.find_by_subject_template_id(template) }
  end

  def semester
    semesters.find_by_id(semester_id)
  end

  def semesters
    school_semesters.between_years(start_year, yearbook)
  end

  def semester_absences(semester)
    SemesterAbsence.new(self, semester)
  end

  def year_absences(year)
    YearAbsence.new(self, year)
  end

  def semester_average(semester)
    averages = AverageSemestralMark.where(["student_id in (?) AND semester_id = ?", students.collect(&:id), semester.id])
  end

  def year_average(year)
    semesters = school.semesters.find_all_by_end_year(year)
    averages = 0
    semesters.each do |semester|
      students.each do |student|
        average = student.semester_average(semester_id)
        averages += average if average
      end
    end
    averages / students.count
  end

  def count_semestral_marks(mark, semester)
    count = 0
    students.each { |student| count += student.semestral_marks.find_all_by_mark_and_semester_id(mark.to_s, semester).count }
    count
  end

  def count_year_marks(mark, year)
    count_semestral_marks(mark, second_semester_by_year(year))
  end

  def activate
    unless active
      teacher.deactivate_school_class
      update_attribute(:active, true)
      teacher.update_attribute(:school_class_id, id)
    end
  end

  def deactivate
    update_attribute(:active, false)
  end

  def activate_semester(semester)
    update_attributes(semester_id:semester.id, grade:check_for_new_grade)
  end

  def check_for_new_grade
    _grade = calculate_grade
    _grade != grade ? _grade : grade
  end

  def average_semestral_mark_for_semester(semester)
    averages = average_semestral_marks.find_all_by_semester_id(semester)
    averages.empty? ? "--" : averages.map(&:average).inject(:+) / averages.count 
  end

  def semester_fullname
    semester.fullname
  end

  def school_semesters
    school.semesters
  end

  def average_semestral_mark_for_year(year)
    average_semestral_mark_for_semester(second_semester_by_year(year))
  end

  def school_semester
    school.semester
  end

  def start_year
    yearbook - period
  end

  def update_mass_required_absences(absence)
    students.each do |student|
      _absence = student.absences.find_by_month_and_week_and_semester_id(absence[:month], absence[:week], school_semester.id)
      _absence ? _absence.update_attributes(required: absence[:required]) : student.absences.create(absence)
    end
  end

  def subjects
    Subject.active.where(["school_class_id = ?", self.id])
  end

  def all_subjects
    Subject.where(["school_class_id = ?", self.id])
  end

  private

    def deactivate_old_school_class
      teacher.deactivate_school_class
    end

    def set_active
      self.active = true
    end

    def set_school_id
      self.school_id = teacher.school_id
    end

    def set_semester_id
      self.semester_id = school_semester.id if school_semester
    end

    def calculate_grade
      _grade = period - (yearbook - Time.now.year)
      _grade += 1 if Time.now.month >= 9
      _grade >= period ? period : _grade
    end

    def set_grade
      self.grade = calculate_grade
    end

    def unset_teacher_school_class_id
      teacher.update_attribute(:school_class_id, nil) if active
    end

    def second_semester_by_year(year)
      @second_semester ||= school_semesters.find_by_start_year_and_semester(year[0..3], 2)
    end

    def set_profile_template_id
      profile_templates.find_all_by_name(profile).each do |profile|
        if profile.start_year <= start_year
          self.profile_template_id = profile.id
          break
        end
      end
    end

    def create_subjects_from_profile_template
      profile_template.subject_templates.each { |subject_template| subjects.create(subject_template_id: subject_template.id) }
    end

end
