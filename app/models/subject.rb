class Subject < ActiveRecord::Base

  belongs_to :school_class

  attr_accessible :name

  before_create :inherit_from_school_class

  private

    def inherit_from_school_class
      self.teacher_id = self.school_class.teacher_id
    end

end