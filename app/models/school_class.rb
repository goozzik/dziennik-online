class SchoolClass < ActiveRecord::Base

  belongs_to :teacher
  has_many :semesters, :dependent => :destroy
  has_many :subjects, :dependent => :destroy
  has_many :students, :dependent => :destroy, :conditions => ['student = ?', true]
  has_many :time_tables, :dependent => :destroy
  attr_accessible :year, :name, :profile, :yearbook, :active
  default_scope :order => 'created_at ASC'

  validates_presence_of :year, :name, :profile, :yearbook

  before_create :unactive_old_school_class, :set_active
  after_create :create_semester

  before_destroy :unset_teacher_school_class_id

  def fullname
    [self.year, self.name, self.yearbook].join(' ')
  end

  def activate
    SchoolClass.deactivate(self.teacher_id)
    self.update_attributes(:active => true)
    self.teacher.update_attributes(:school_class_id => self.id)
  end

  def self.deactivate(teacher_id)
    active_school_class = SchoolClass.first(:conditions => ['teacher_id = ? AND active = ?', teacher_id, true])
    active_school_class.update_attributes(:active => false) if active_school_class
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
      self.teacher.update_attributes(:school_class_id => nil) if self.active
    end

end
