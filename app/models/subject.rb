class Subject < ActiveRecord::Base

  belongs_to :school_class
  has_many :lessons, :dependent => :destroy
  has_many :descriptions, :dependent => :destroy

  attr_accessible :name

  before_create :inherit_from_school_class

  private

    def inherit_from_school_class
      self.teacher_id = self.school_class.teacher_id
    end

end
