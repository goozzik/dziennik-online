class SchoolClass < ActiveRecord::Base

  belongs_to :teacher
  attr_accessible :year, :name, :profile, :yearbook
  validates_presence_of :year, :name, :profile, :yearbook
  after_create :set_teacher_current_class

  def fullname
    [self.year, self.name, self.yearbook].join(' ')
  end

  def set_teacher_current_class
    self.teacher.update_attributes(:class_id => self.id)
  end

end
