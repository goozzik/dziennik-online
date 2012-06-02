class SemestralMark < ActiveRecord::Base

  belongs_to :student
  belongs_to :semester
  belongs_to :subject
  belongs_to :school_class

  scope :current, joins(:semester).where(["semesters.active = ?", true])

  attr_accessible :mark, :student_id, :subject_id, :semester_id

  validates :mark, :presence => true
  validates :student_id, :presence => true
  validates :subject_id, :presence => true

  before_create :set_school_class_id, :set_semester_id

  private

    def set_school_class_id
      self.school_class_id = student.school_class_id
    end

    def set_semester_id
      self.semester_id = school_class.semester_id
    end

end
