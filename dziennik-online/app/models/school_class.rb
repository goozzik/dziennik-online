class SchoolClass < ActiveRecord::Base

  belongs_to :teacher
  attr_accessible :year, :name, :profile, :yearbook
  validates_presence_of :year, :name, :profile, :yearbook

  def fullname
    [self.year, self.name, self.yearbook].join(' ')
  end

end
