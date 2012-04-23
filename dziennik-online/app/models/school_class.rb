class SchoolClass < ActiveRecord::Base

  belongs_to :teacher
  attr_accessible :year, :name, :profile, :yearbook

  def fullname
    [self.year, self.name, self.yearbook].join(' ')
  end

end
