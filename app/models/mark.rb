class Mark < ActiveRecord::Base

  belongs_to :description
  belongs_to :semester
  belongs_to :student
  belongs_to :subject

  attr_accessible :mark, :student_id, :description_id, :subject_id, :semester_id

  def self.find_all_by_students_and_descriptions(students, descriptions)
    marks = []
    students.each_with_index do |student, i|
      marks[i] = []
      descriptions.each_with_index do |description, j|
        marks[i][j] = Mark.find_by_student_id_and_description_id(student.id, description.id)
      end
    end
    marks
  end

end
