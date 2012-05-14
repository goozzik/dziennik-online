class Student::AbsencesController < ApplicationController

  def index
    @month = 0
    @student = current_student
    @absences = current_student.absences
  end

end
