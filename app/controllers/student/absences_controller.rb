class Student::AbsencesController < ApplicationController

  before_filter :authenticate_student!

  def index
    @month = 0
    @student = current_student
    @absences = current_student.absences
  end

end
