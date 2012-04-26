class Description < ActiveRecord::Base

  belongs_to :semester
  belongs_to :subject
  has_many :marks, :dependent => :destroy

  attr_accessible :subject_id, :semester_id, :desc_type, :description, :colour

  before_create :inherit_from_subject

  private

    def inherit_from_subject
      self.semester_id = self.subject.school_class.teacher.semester_id
    end

end
