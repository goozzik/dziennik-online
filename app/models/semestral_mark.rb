# coding: utf-8
class SemestralMark < ActiveRecord::Base

  AVAILABLE_MARKS = %w{1 2 3 4 5 6 nkl zw}

  scope :current, joins(:semester).where(["semesters.active = ?", true])

  belongs_to :student
  belongs_to :semester
  belongs_to :subject
  belongs_to :school_class

  attr_accessible :mark, :student_id, :subject_id

  validates :mark, :presence => true
  validate :validate_mark_format
  validates :student_id, :presence => true
  validates :subject_id, :presence => true

  before_create :set_school_class_id, :set_semester_id

  after_save :update_semestral_average_mark

  private

    def validate_mark_format
      unless AVAILABLE_MARKS.include?(mark)
        errors.add(:mark, "nie prawidłowa ocena")
        return false
      end
    end

    def set_school_class_id
      self.school_class_id = student.school_class_id
    end

    def set_semester_id
      self.semester_id = school_class.semester_id unless semester_id.present?
    end

    def update_semestral_average_mark
      student.average_semestral_marks.find_or_create_by_semester_id(semester_id).update_average
    end

end
