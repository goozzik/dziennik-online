class SchoolClass < ActiveRecord::Base

  belongs_to :teacher

  def fullname
    [self.year, self.name, self.yearbook].join(' ')
  end

end
