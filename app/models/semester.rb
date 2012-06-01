class Semester < ActiveRecord::Base

  belongs_to :school

  has_many :absences, :dependent => :destroy
  has_many :descriptions, :dependent => :destroy
  has_many :semestral_marks, :dependent => :destroy
  has_many :marks, :dependent => :destroy

  attr_accessible :start_year, :end_year, :semester, :active
  #default_scope :order => 'created_at ASC'

  validates :start_year, :presence => true
  validates :end_year, :presence => true
  validates :semester, :presence => true

  def activate
    unless active
      school.deactivate_semester
      update_attributes(:active => true)
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

end
