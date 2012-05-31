# coding: utf-8
class SchoolClass < ActiveRecord::Base

  default_scope :order => 'yearbook DESC'

  belongs_to :school
  belongs_to :teacher

  has_many :subjects, :dependent => :destroy
  has_many :students, :dependent => :destroy, :conditions => ['student = ?', true]
  has_many :time_tables, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  has_many :messages, :dependent => :destroy

  attr_accessible :name, :profile, :yearbook, :active, :school_id

  validates_presence_of :name, :profile, :yearbook

  before_create :deactivate_old_school_class, :set_active, :set_school_id, :set_semester_id

  before_destroy :unset_teacher_school_class_id

  WEEK_DAYS = {0 => 'Niedziela',
               1 => 'Poniedziałek',
               2 => 'Wtorek',
               3 => 'Środa',
               4 => 'Czwartek',
               5 => 'Piątek',
               6 => 'Sobota'}

  def fullname
    [yearbook, name, profile].join(' ')
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

  def available_time_table_days
    WEEK_DAYS.delete_if { |i, week_day| time_tables.find_by_week_day(i) }
  end

  def available_subject_templates
    SubjectTemplate.all.delete_if { |template| subjects.find_by_subject_template_id(template) }
  end

  def school_semesters
    school.semesters.where(["end_year <= ?", yearbook])
  end

  def teacher_school_class
    teacher.school_class
  end

  def semester
    school_semesters.find_by_id(semester_id)
  end

  def school_semester
    school.semester
  end

  def activate_semester(semester)
    update_attribute(:semester_id, semester.id)
  end

  def semester_marks
    semester.marks
  end

  def semester_semestral_marks
    semester.semestral_marks
  end

  def semesters
    school.semesters.find(:all, :conditions => ["end_year <= ?", yearbook])
  end

  def semester_absences(semester_id)
    required = justified = unexcused = late = 0
    students.each do |student|
      absences = student.absences.find_all_by_semester_id(semester_id)
      absences.each do |absence|
        required += absence.required if absence.required
        justified += absence.justified if absence.justified
        unexcused += absence.unexcused if absence.unexcused
        late += absence.late if absence.late
      end
    end
    percentage = sprintf("%1.2f", (required - (justified + unexcused)).to_f / required * 100)
    { :percentage => percentage == "NaN" ? "--" : percentage,
      :required => required,
      :justified => justified,
      :unexcused => unexcused,
      :late => late
    }
  end

  def year_absences(year)
    required = justified = unexcused = late = 0
    semesters = school.semesters.find_all_by_end_year(year)
    semesters.each do |semester|
      students.each do |student|
        absences = student.absences.find_all_by_semester_id(semester.id)
        absences.each do |absence|
          required += absence.required if absence.required
          justified += absence.justified if absence.justified
          unexcused += absence.unexcused if absence.unexcused
          late += absence.late if absence.late
        end
      end
    end
    percentage = sprintf("%1.2f", (required - (justified + unexcused)).to_f / required * 100)
    { :percentage => percentage == "NaN" ? "--" : percentage,
      :required => required,
      :justified => justified,
      :unexcused => unexcused,
      :late => late
    }
  end

  def semester_average(semester_id)
    averages = 0
    students.each do |student|
      average = student.semester_average(semester_id)
      averages += average if average
    end
    averages / students.count
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

  def count_semestral_marks(mark, semester_id)
    count = 0
    students.each { |student| count += student.semestral_marks.find_all_by_mark_and_semester_id(mark, semester_id).count }
    count
  end

  def count_year_marks(mark, year)
    semesters = school.semesters.find_all_by_end_year(year)
    count = 0
    semesters.each do |semester|
      students.each { |student| count += student.semestral_marks.find_all_by_mark_and_semester_id(mark, semester_id).count }
    end
    count
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
      self.semester_id = school_semester.id
    end

    def unset_teacher_school_class_id
      teacher.update_attribute(:school_class_id, nil) if active
    end

end
