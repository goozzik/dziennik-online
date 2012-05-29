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
