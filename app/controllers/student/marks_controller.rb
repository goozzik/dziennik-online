class Student::MarksController < ApplicationController

  def index
    @student = current_student
    @subjects = current_student.subjects
  end

end
