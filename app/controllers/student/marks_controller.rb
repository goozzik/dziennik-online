class Student::MarksController < ApplicationController

  before_filter :authenticate_student!

  def index
    @student = current_student
    @subjects = current_student.subjects
  end

end
