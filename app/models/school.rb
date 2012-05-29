class School < ActiveRecord::Base

  has_many :admins, :dependent => :destroy
  has_many :directors, :dependent => :destroy
  has_many :teachers, :dependent => :destroy
  has_many :school_classes, :dependent => :destroy
  has_many :semesters, :dependent => :destroy
  has_many :students, :dependent => :destroy

  def semester
    semesters.find_by_active(true)
  end

  def deactivate_semester
    semester.deactivate if semester
  end

end
