class SchoolClass < ActiveRecord::Base

  belongs_to :teacher
  has_many :semesters, :dependent => :destroy
  attr_accessible :year, :name, :profile, :yearbook, :active

  validates_presence_of :year, :name, :profile, :yearbook

  before_create :unactive_old_school_class, :set_active
  after_create :create_semester

  before_destroy :unset_teacher_school_class_id, :if => :active

  def fullname
    [self.year, self.name, self.yearbook].join(' ')
  end

  private

    def unactive_old_school_class
      old_active_school_class = SchoolClass.first(:conditions => ['teacher_id = ? AND active = ?', self.teacher_id, true])
      old_active_school_class.update_attributes(:active => false) if old_active_school_class
    end

    def set_active
      self.active = true
    end

    def create_semester
      semester = self.semesters.build(:active => true)
      semester.save
    end

    def unset_teacher_school_class_id
      self.teacher.update_attributes(:school_class_id => nil)
    end

end
