# coding: utf-8
class Semester < ActiveRecord::Base

  belongs_to :school

  has_many :absences, :dependent => :destroy
  has_many :descriptions, :dependent => :destroy
  has_many :semestral_marks, :dependent => :destroy
  has_many :marks, :dependent => :destroy

  attr_accessible :start_year, :end_year, :semester, :active
  default_scope :order => 'start_year DESC, semester DESC'

  before_create :set_active_if_first

  validates :start_year, :presence => true
  validates :end_year, :presence => true
  validates :semester, :presence => true, :uniqueness => {:scope => [:school_id, :start_year, :end_year], :message => "już istnieje"}
  validate :validate_end_year_is_later, :validate_difference_between_years

  delegate :school_classes, :to => :school

  def activate
    unless active
      school.deactivate_semester
      update_attribute(:active, true) && update_school_classes_semester_id
    end
  end

  def deactivate
    update_attribute(:active, false)
  end

  def is_active_in_school_class?(school_class)
    @is_active_in_school_class ||= school_class.semester == self
  end

  def fullname
    years + " Semestr #{semester}"
  end

  def years
    "#{start_year}/#{end_year}"
  end

  def self.between_years(start_year, end_year)
    where(["start_year >= ? AND end_year <= ?", start_year, end_year])
  end

  def school_year
    "#{start_year}/#{end_year}"
  end

  def archive
    update_attribute(:archived, true)
  end

  def unarchive
    update_attribute(:archived, false)
  end

  private

    def set_active_if_first
      self.active = true if school.semesters.count == 0
    end

    def validate_end_year_is_later
      if start_year && end_year && start_year > end_year
        errors.add(:end_year, "musi być późniejszy niż rok rozpoczęcia") 
        return false
      end
      true
    end

    def validate_difference_between_years
      if start_year && end_year && end_year - start_year > 1
        errors.add(:end_year, "zbyt duża różnica")
        return false
      end
      true
    end

    def update_school_classes_semester_id
      school_classes.active.each { |school_class| school_class.activate_semester(self) }
    end

end
