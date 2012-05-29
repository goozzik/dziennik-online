class Description < ActiveRecord::Base

  belongs_to :semester
  belongs_to :subject

  has_many :marks, :dependent => :destroy

  attr_accessible :subject_id, :semester_id, :desc_type, :description, :colour

  before_create :set_semester_id

  def subject_school_class_semester
    subject.school_class_semester
  end

  private

    def set_semester_id
      self.semester_id = subject_school_class_semester.id
    end

end
