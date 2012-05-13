class Student::SubjectsController < ApplicationController

  def index
    @subjects = current_student.subjects
  end

end
