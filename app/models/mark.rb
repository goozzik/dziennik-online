class Mark < ActiveRecord::Base

  belongs_to :description
  belongs_to :semester
  belongs_to :student
  belongs_to :subject

  attr_accessible :mark, :student_id, :description_id, :subject_id

  scope :current, joins(:semester).where(["semesters.active = ?", true])

  before_create :set_subject_id, :set_semester_id

  def self.average_from_marks(marks)
    sprintf("%1.2f", marks.empty? ? 0.0 : marks.collect { |m| m.mark.to_i }.inject(:+).to_f / marks.count)
  end

  private

    def set_subject_id
      self.subject_id = description.subject_id
    end

    def set_semester_id
      self.semester_id = description.semester_id
    end

end
