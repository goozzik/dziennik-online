class Mark < ActiveRecord::Base

  belongs_to :description
  belongs_to :semester

  attr_accessible :mark, :student_id, :description_id, :subject_id

  before_create :inherit_from_semester

  def self.find_by_students_and_descriptions(students, descriptions)
    marks = []
    students.each_with_index do |student, i|
      marks[i] = []
      descriptions.each_with_index do |description, j|
        marks[i][j] = Mark.find_by_student_id_and_description_id(student.id, description.id)
      end
    end
    marks
  end

  private

    def inherit_from_semester
      school_class_id = semester.school_class_id
    end

end
