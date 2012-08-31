class Description < ActiveRecord::Base

  default_scope :order => 'created_at ASC'

  scope :current, joins(:semester).where(["semesters.active = ?", true])

  belongs_to :semester
  belongs_to :subject

  has_many :marks, :dependent => :destroy

  attr_accessible :subject_id, :semester_id, :desc_type, :description

  before_create :set_semester_id

  validates :desc_type, :presence => true
  validates :description, :presence => true

  private

    def set_semester_id
      self.semester_id = subject.school_class.semester_id
    end

end
