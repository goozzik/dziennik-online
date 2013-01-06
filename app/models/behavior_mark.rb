# coding: utf-8

class BehaviorMark < ActiveRecord::Base

  AVAILABLE_MARKS = ["naganne", "nieodpowiednie", "poprawne", "dobre", "bardzo dobre", "wzorowe"]

  belongs_to :semester
  belongs_to :school_class
  belongs_to :student

  attr_accessible :student_id, :mark

  before_validation :decode_mark, :set_school_class_id, :set_semester_id

  validate :validate_mark_format

  private

    def decode_mark
      case mark
      when "1" then self.mark = "naganne"
      when "2" then self.mark = "nieodpowiednie"
      when "3" then self.mark = "poprawne"
      when "4" then self.mark = "dobre"
      when "5" then self.mark = "bardzo dobre"
      when "6" then self.mark = "wzorowe"
      end
    end

    def set_school_class_id
      self.school_class_id = student.school_class_id
    end

    def set_semester_id
      self.semester_id = school_class.semester_id
    end

    def validate_mark_format
      unless AVAILABLE_MARKS.include?(mark)
        errors.add(:mark, "nie prawidłowa ocena")
        return false
      end
    end

end
