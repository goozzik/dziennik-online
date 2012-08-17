# coding: utf-8
class Mark < ActiveRecord::Base

  AVAILABLE_MARKS = %w{1 1+ 2 2- 2+ 3 3- 3+ 4 4- 4+ 5 5- 5+ 6 6- 6+}

  scope :current, joins(:semester).where(["semesters.active = ?", true])

  belongs_to :description
  belongs_to :semester
  belongs_to :student
  belongs_to :subject

  attr_accessible :mark, :student_id, :description_id, :subject_id

  before_validation :remove_spaces
  validate :validate_mark_format

  before_create :set_semester_id

  def self.average_from_marks(marks)
    sprintf("%1.2f", marks.empty? ? 0.0 : marks.collect { |m| m.mark.to_i }.inject(:+).to_f / marks.count)
  end

  private

    def validate_mark_format
      unless AVAILABLE_MARKS.include?(mark)
        errors.add(:mark, "nie prawidłowa ocena")
        return false
      end
    end

    def set_semester_id
      self.semester_id = description.semester_id
    end

    # in case of FireFox javascript bugs
    def remove_spaces
      self.mark = mark.gsub(' ', '')[0]
    end

end
