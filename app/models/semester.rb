# coding: utf-8
class Semester < ActiveRecord::Base

  belongs_to :school

  has_many :absences, :dependent => :destroy
  has_many :descriptions, :dependent => :destroy
  has_many :semestral_marks, :dependent => :destroy
  has_many :marks, :dependent => :destroy

  attr_accessible :start_year, :end_year, :semester, :active
  #default_scope :order => 'created_at ASC'

  before_create :set_active_if_first

  validates :start_year, :presence => true
  validates :end_year, :presence => true
  validates :semester, :presence => true
  validate :validate_end_year_is_later, :validate_difference_between_years

  def activate
    unless active
      school.deactivate_semester
      update_attribute(:active, true)
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

  def self.before_year(year)
    where(["end_year <= ?", year])
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
        errors.add(:end_year, "zbyt duża rożnica") 
        return false
      end
      true
    end

end
