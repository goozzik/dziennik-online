# coding: utf-8
class Semester < ActiveRecord::Base

  default_scope :order => 'start_year DESC, semester DESC'

  belongs_to :school
  has_many :absences, :dependent => :destroy
  has_many :descriptions, :dependent => :destroy
  has_many :semestral_marks, :dependent => :destroy
  has_many :marks, :dependent => :destroy

  attr_accessible :start_year, :end_year, :semester

  validates_presence_of :start_year, :end_year, :semester, :school_id
  validates :semester, :uniqueness => {:scope => [:school_id, :start_year, :end_year], :message => "już istnieje"}
  validate :end_year_should_be_later, :should_be_one_year_difference

  before_create :set_active_if_first

  delegate :school_classes, :to => :school

  def self.between_years(start_year, end_year)
    where(["start_year >= ? AND end_year <= ?", start_year, end_year])
  end

  def school_year
    "#{start_year}/#{end_year}"
  end

  def fullname
    school_year + " Semestr #{semester}"
  end

  def activate
    unless active
      school.deactivate_semester
      update_attribute(:active, true)
      update_school_classes_semester_id
    end
  end

  def deactivate
    update_attribute(:active, false)
  end

  def is_active_in_school_class?(school_class)
    school_class.semester_id == id
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

    def end_year_should_be_later
      if start_year.present? && end_year.present? && start_year > end_year
        errors.add(:end_year, "musi być późniejszy niż rok rozpoczęcia")
      end
    end

    def should_be_one_year_difference
      if end_year.present? && start_year.present? && end_year - start_year > 1
        errors.add(:end_year, "zbyt duża różnica")
      end
    end

    def update_school_classes_semester_id
      school_classes.active.each { |school_class| school_class.activate_semester(id) }
    end

end
