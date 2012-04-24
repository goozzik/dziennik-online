class SchoolClass < ActiveRecord::Base

  belongs_to :teacher
  has_many :semesters
  attr_accessible :year, :name, :profile, :yearbook
  validates_presence_of :year, :name, :profile, :yearbook

  after_create :set_teacher_current_class, :create_semester
  before_create :set_unactive, :set_active

  def fullname
    [self.year, self.name, self.yearbook].join(' ')
  end


  private

    def set_teacher_current_class
      self.teacher.update_attributes(:school_class_id => self.id)
    end

    def set_unactive
      school_class = SchoolClass.first(:conditions => ['teacher_id = ? AND active = ?', self.teacher_id, true])
      school_class.try('update_attributes(:active => false)')
    end

    def set_active
      self.active = true
    end

    def create_semester
      semester = self.semesters.build(:semester => 1, :active => true)
      semester.save
    end


end
